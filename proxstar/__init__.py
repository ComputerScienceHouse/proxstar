import os
import time
import subprocess
from rq import Queue
from redis import Redis
from rq_scheduler import Scheduler
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from werkzeug.contrib.cache import SimpleCache
from flask_pyoidc.flask_pyoidc import OIDCAuthentication
from flask import Flask, render_template, request, redirect, send_from_directory, session
from proxstar.db import *
from proxstar.util import *
from proxstar.tasks import *
from proxstar.starrs import *
from proxstar.ldapdb import *
from proxstar.proxmox import *

app = Flask(__name__)
if os.path.exists(
        os.path.join(
            app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")):
    config = os.path.join(
        app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")
else:
    config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)
app.config["GIT_REVISION"] = subprocess.check_output(
    ['git', 'rev-parse', '--short', 'HEAD']).decode('utf-8').rstrip()

retry = 0
while retry < 5:
    try:
        auth = OIDCAuthentication(
            app,
            issuer=app.config['OIDC_ISSUER'],
            client_registration_info=app.config['OIDC_CLIENT_CONFIG'])
        break
    except:
        retry += 1
        time.sleep(2)

cache = SimpleCache()

redis_conn = Redis(app.config['REDIS_HOST'], app.config['REDIS_PORT'])
q = Queue(connection=redis_conn)
scheduler = Scheduler(connection=redis_conn)

engine = create_engine(app.config['SQLALCHEMY_DATABASE_URI'])
Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)
db = DBSession()

starrs = psycopg2.connect(
    "dbname='{}' user='{}' host='{}' password='{}'".format(
        app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'],
        app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS']))

if 'generate_pool_cache' not in scheduler:
    scheduler.schedule(
        id='generate_pool_cache',
        scheduled_time=datetime.datetime.utcnow(),
        func=generate_pool_cache_task,
        interval=60)

if 'process_expiring_vms' not in scheduler:
    scheduler.cron(
        '0 5 * * *', id='process_expiring_vms', func=process_expiring_vms_task)


@app.route("/")
@app.route("/user/<string:user>")
@auth.oidc_auth
def list_vms(user=None):
    rtp_view = False
    rtp = 'rtp' in session['userinfo']['groups']
    active = 'active' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if user and not rtp:
        return '', 403
    elif user and rtp:
        vms = get_vms_for_user(proxmox, db, user)
        rtp_view = user
        user = session['userinfo']['preferred_username']
    elif rtp:
        user = session['userinfo']['preferred_username']
        vms = get_pool_cache(db)
        rtp_view = True
    else:
        user = session['userinfo']['preferred_username']
        if active:
            vms = get_vms_for_user(proxmox, db, user)
        else:
            vms = 'INACTIVE'
    return render_template(
        'list_vms.html',
        username=user,
        rtp=rtp,
        active=active,
        rtp_view=rtp_view,
        vms=vms)


@app.route("/isos")
@auth.oidc_auth
def isos():
    proxmox = connect_proxmox()
    isos = get_isos(proxmox, app.config['PROXMOX_ISO_STORAGE'])
    return ','.join(isos)


@app.route("/hostname/<string:name>")
@auth.oidc_auth
def hostname(name):
    valid, available = check_hostname(starrs, name)
    if not valid:
        return 'invalid'
    if not available:
        return 'taken'
    else:
        return 'ok'


@app.route("/vm/<string:vmid>")
@auth.oidc_auth
def vm_details(vmid):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    active = 'active' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        vm = get_vm(proxmox, vmid)
        vm['vmid'] = vmid
        vm['config'] = get_vm_config(proxmox, vmid)
        vm['disks'] = get_vm_disks(proxmox, vmid, config=vm['config'])
        vm['iso'] = get_vm_iso(proxmox, vmid, config=vm['config'])
        vm['interfaces'] = []
        for interface in get_vm_interfaces(
                proxmox, vm['vmid'], config=vm['config']):
            vm['interfaces'].append(
                [interface[0],
                 get_ip_for_mac(starrs, interface[1])])
        vm['expire'] = get_vm_expire(
            db, vmid, app.config['VM_EXPIRE_MONTHS']).strftime('%m/%d/%Y')
        usage = get_user_usage(proxmox, db, user)
        limits = get_user_usage_limits(db, user)
        usage_check = check_user_usage(proxmox, db, user,
                                       vm['config']['cores'],
                                       vm['config']['memory'], 0)
        return render_template(
            'vm_details.html',
            username=user,
            rtp=rtp,
            active=active,
            vm=vm,
            usage=usage,
            limits=limits,
            usage_check=usage_check)
    else:
        return '', 403


@app.route("/vm/<string:vmid>/power/<string:action>", methods=['POST'])
@auth.oidc_auth
def vm_power(vmid, action):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        if action == 'start':
            config = get_vm_config(proxmox, vmid)
            usage_check = check_user_usage(proxmox, db, user, config['cores'],
                                           config['memory'], 0)
            if usage_check:
                return usage_check
        change_vm_power(proxmox, vmid, action)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/cpu/<int:cores>", methods=['POST'])
@auth.oidc_auth
def vm_cpu(vmid, cores):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        cur_cores = get_vm_config(proxmox, vmid)['cores']
        if cores >= cur_cores:
            status = get_vm(proxmox, vmid)['qmpstatus']
            if status == 'running' or status == 'paused':
                usage_check = check_user_usage(proxmox, db, user,
                                               cores - cur_cores, 0, 0)
            else:
                usage_check = check_user_usage(proxmox, db, user, cores, 0, 0)
            if usage_check:
                return usage_check
        change_vm_cpu(proxmox, vmid, cores)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/mem/<int:mem>", methods=['POST'])
@auth.oidc_auth
def vm_mem(vmid, mem):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        cur_mem = get_vm_config(proxmox, vmid)['memory'] // 1024
        if mem >= cur_mem:
            status = get_vm(proxmox, vmid)['qmpstatus']
            if status == 'running' or status == 'paused':
                usage_check = check_user_usage(proxmox, db, user, 0,
                                               mem - cur_mem, 0)
            else:
                usage_check = check_user_usage(proxmox, db, user, 0, mem, 0)
            if usage_check:
                return usage_check
        change_vm_mem(proxmox, vmid, mem * 1024)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/renew", methods=['POST'])
@auth.oidc_auth
def vm_renew(vmid):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        renew_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])
        for interface in get_vm_interfaces(proxmox, vmid):
            renew_ip(starrs, get_ip_for_mac(starrs, interface[1]))
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/eject", methods=['POST'])
@auth.oidc_auth
def iso_eject(vmid):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        eject_vm_iso(proxmox, vmid)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/mount/<string:iso>", methods=['POST'])
@auth.oidc_auth
def iso_mount(vmid, iso):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(proxmox, db, user):
        iso = "{}:iso/{}".format(app.config['PROXMOX_ISO_STORAGE'], iso)
        mount_vm_iso(proxmox, vmid, iso)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/delete", methods=['POST'])
@auth.oidc_auth
def delete(vmid):
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if rtp or int(vmid) in get_user_allowed_vms(
            proxmox, db, user) or 'rtp' in session['userinfo']['groups']:
        q.enqueue(delete_vm_task, vmid)
        return '', 200
    else:
        return '', 403


@app.route("/vm/create", methods=['GET', 'POST'])
@auth.oidc_auth
def create():
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    active = 'active' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    if active:
        if request.method == 'GET':
            usage = get_user_usage(proxmox, db, user)
            limits = get_user_usage_limits(db, user)
            percents = get_user_usage_percent(proxmox, user, usage, limits)
            isos = get_isos(proxmox, app.config['PROXMOX_ISO_STORAGE'])
            pools = get_pools(proxmox, db)
            templates = get_templates(db)
            return render_template(
                'create.html',
                username=user,
                rtp=rtp,
                active=active,
                usage=usage,
                limits=limits,
                percents=percents,
                isos=isos,
                pools=pools,
                templates=templates)
        elif request.method == 'POST':
            name = request.form['name']
            cores = request.form['cores']
            memory = request.form['mem']
            template = request.form['template']
            disk = request.form['disk']
            iso = request.form['iso']
            if iso != 'none':
                iso = "{}:iso/{}".format(app.config['PROXMOX_ISO_STORAGE'],
                                         iso)
            if not rtp:
                usage_check = check_user_usage(proxmox, db, user, 0, 0, disk)
            else:
                usage_check = None
                user = request.form['user']
            if usage_check:
                return usage_check
            else:
                valid, available = check_hostname(starrs, name)
                if valid and available:
                    if template == 'none':
                        q.enqueue(
                            create_vm_task,
                            user,
                            name,
                            cores,
                            memory,
                            disk,
                            iso,
                            timeout=300)
                    else:
                        password = gen_password(16)
                        q.enqueue(
                            setup_template,
                            template,
                            name,
                            user,
                            password,
                            cores,
                            memory,
                            timeout=600)
                        return password, 200
            return '', 200
    else:
        return '', 403


@app.route('/limits/<string:user>', methods=['POST'])
@auth.oidc_auth
def set_limits(user):
    if 'rtp' in session['userinfo']['groups']:
        cpu = request.form['cpu']
        mem = request.form['mem']
        disk = request.form['disk']
        set_user_usage_limits(user, cpu, mem, disk)
        return '', 200
    else:
        return '', 403


@app.route('/user/<string:user>/delete', methods=['POST'])
@auth.oidc_auth
def delete_user(user):
    if 'rtp' in session['userinfo']['groups']:
        proxmox = connect_proxmox()
        delete_user_pool(proxmox, user)
        cache.delete('vms')
        return '', 200
    else:
        return '', 403


@app.route("/settings")
@auth.oidc_auth
def settings():
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    active = 'active' in session['userinfo']['groups']
    if rtp:
        templates = get_templates(db)
        ignored_pools = get_ignored_pools(db)
        return render_template(
            'settings.html',
            username=user,
            rtp=rtp,
            active=active,
            templates=templates,
            ignored_pools=ignored_pools)
    else:
        return '', 403


@app.route("/pool/<string:pool>/ignore", methods=['POST', 'DELETE'])
@auth.oidc_auth
def ignored_pools(pool):
    if 'rtp' in session['userinfo']['groups']:
        if request.method == 'POST':
            add_ignored_pool(db, pool)
        elif request.method == "DELETE":
            delete_ignored_pool(db, pool)
        return '', 200
    else:
        return '', 403


@app.route('/template/<string:template_id>/disk')
@auth.oidc_auth
def template_disk(template_id):
    if template_id == 'none':
        return '0'
    return get_template_disk(db, template_id)


@app.route('/vm/<string:vmid>/rrd/<path:path>')
@auth.oidc_auth
def send_rrd(vmid, path):
    return send_from_directory("rrd/{}".format(vmid), path)


@app.route('/novnc/<path:path>')
@auth.oidc_auth
def send_novnc(path):
    return send_from_directory('static/novnc-pve/novnc', path)


@app.route("/logout")
@auth.oidc_logout
def logout():
    return redirect(url_for('list_vms'), 302)


if __name__ == "__main__":
    app.run()
