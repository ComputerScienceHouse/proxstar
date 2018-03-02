import os
import time
import psutil
import atexit
import psycopg2
import subprocess
from rq import Queue
from redis import Redis
from rq_scheduler import Scheduler
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from flask_pyoidc.flask_pyoidc import OIDCAuthentication
from flask import Flask, render_template, request, redirect, session
from proxstar.db import *
from proxstar.vm import VM
from proxstar.vnc import *
from proxstar.util import gen_password
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

with open('proxmox_ssh_key', 'w') as key:
    key.write(app.config['PROXMOX_SSH_KEY'])

ssh_tunnels = []

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

from proxstar.user import User
from proxstar.tasks import generate_pool_cache_task, process_expiring_vms_task, cleanup_vnc_task, delete_vm_task, create_vm_task, setup_template_task

if 'generate_pool_cache' not in scheduler:
    scheduler.schedule(
        id='generate_pool_cache',
        scheduled_time=datetime.datetime.utcnow(),
        func=generate_pool_cache_task,
        interval=90)

if 'process_expiring_vms' not in scheduler:
    scheduler.cron(
        '0 5 * * *', id='process_expiring_vms', func=process_expiring_vms_task)

if 'cleanup_vnc' not in scheduler:
    scheduler.schedule(
        id='cleanup_vnc',
        scheduled_time=datetime.datetime.utcnow(),
        func=cleanup_vnc_task,
        interval=3600)


@app.route("/")
@app.route("/user/<string:user_view>")
@auth.oidc_auth
def list_vms(user_view=None):
    user = User(session['userinfo']['preferred_username'])
    rtp_view = False
    proxmox = connect_proxmox()
    if user_view and not user.rtp:
        return '', 403
    elif user_view and user.rtp:
        vms = User(user_view).vms
        rtp_view = user_view
    elif user.rtp:
        vms = get_pool_cache(db)
        rtp_view = True
    else:
        if user.active:
            vms = user.vms
        else:
            vms = 'INACTIVE'
    return render_template(
        'list_vms.html', user=user, rtp_view=rtp_view, vms=vms)


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
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        vm_dict = vm.info
        vm_dict['vmid'] = vmid
        vm_dict['config'] = vm.config
        vm_dict['node'] = vm.node
        vm_dict['disks'] = vm.get_disks()
        vm_dict['iso'] = vm.get_iso()
        vm_dict['interfaces'] = []
        for interface in vm.get_interfaces():
            vm_dict['interfaces'].append(
                [interface[0],
                 get_ip_for_mac(starrs, interface[1])])
        vm_dict['expire'] = get_vm_expire(
            db, vmid, app.config['VM_EXPIRE_MONTHS']).strftime('%m/%d/%Y')
        usage_check = user.check_usage(vm_dict['config']['cores'],
                                       vm_dict['config']['memory'], 0)
        return render_template(
            'vm_details.html',
            user=user,
            vm=vm_dict,
            usage=user.usage,
            limits=user.limits,
            usage_check=usage_check)
    else:
        return '', 403


@app.route("/vm/<string:vmid>/power/<string:action>", methods=['POST'])
@auth.oidc_auth
def vm_power(vmid, action):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        if action == 'start':
            config = vm.config
            usage_check = user.check_usage(config['cores'], config['memory'],
                                           0)
            if usage_check:
                return usage_check
            vm.start()
        elif action == 'stop':
            vm.stop()
        elif action == 'shutdown':
            vm.shutdown()
        elif action == 'reset':
            vm.reset()
        elif action == 'suspend':
            vm.suspend()
        elif action == 'resume':
            vm.resume()
        return '', 200
    else:
        return '', 403


@app.route("/console/vm/<string:vmid>", methods=['POST'])
@auth.oidc_auth
def vm_console(vmid):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        port = str(5900 + int(vmid))
        token = add_vnc_target(port)
        node = "{}.csh.rit.edu".format(vm.node)
        tunnel = next((tunnel for tunnel in ssh_tunnels
                       if tunnel.local_bind_port == int(port)), None)
        if tunnel:
            if tunnel.ssh_host != node:
                print(
                    "Tunnel already exists for VM {} to the wrong Proxmox node.".
                    format(vmid))
                tunnel.stop()
                ssh_tunnels.remove(tunnel)
                print("Creating SSH tunnel to {} for VM {}.".format(
                    node, vmid))
                tunnel = start_ssh_tunnel(node, port)
                ssh_tunnels.append(tunnel)
                vm.start_vnc(port)
            else:
                print("Tunnel already exists to {} for VM {}.".format(
                    node, vmid))
        else:
            print("Creating SSH tunnel to {} for VM {}.".format(node, vmid))
            tunnel = start_ssh_tunnel(node, port)
            ssh_tunnels.append(tunnel)
            vm.start_vnc(port)
        return token, 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/cpu/<int:cores>", methods=['POST'])
@auth.oidc_auth
def vm_cpu(vmid, cores):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        cur_cores = vm.cpu
        if cores >= cur_cores:
            if vm.qmpstatus == 'running' or vm.qmpstatus == 'paused':
                usage_check = user.check_usage(cores - cur_cores, 0, 0)
            else:
                usage_check = user.check_usage(cores, 0, 0)
            if usage_check:
                return usage_check
        vm.set_cpu(cores)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/mem/<int:mem>", methods=['POST'])
@auth.oidc_auth
def vm_mem(vmid, mem):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        cur_mem = vm.mem // 1024
        if mem >= cur_mem:
            if vm.qmpstatus == 'running' or vm.qmpstatus == 'paused':
                usage_check = user.check_usage(0, mem - cur_mem, 0)
            else:
                usage_check = user.check_usage(0, mem, 0)
            if usage_check:
                return usage_check
        vm.set_mem(mem * 1024)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/disk/<string:disk>/<int:size>", methods=['POST'])
@auth.oidc_auth
def vm_disk(vmid, disk, size):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        cur_cores = vm.cpu
        usage_check = user.check_usage(0, 0, size)
        if usage_check:
            return usage_check
        vm.resize_disk(disk, size)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/renew", methods=['POST'])
@auth.oidc_auth
def vm_renew(vmid):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        renew_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])
        for interface in vm.get_interfaces():
            renew_ip(starrs, get_ip_for_mac(starrs, interface[1]))
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/eject", methods=['POST'])
@auth.oidc_auth
def iso_eject(vmid):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        vm = VM(vmid)
        vm.eject_iso()
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/mount/<string:iso>", methods=['POST'])
@auth.oidc_auth
def iso_mount(vmid, iso):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        iso = "{}:iso/{}".format(app.config['PROXMOX_ISO_STORAGE'], iso)
        vm = VM(vmid)
        vm.mount_iso(iso)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/delete", methods=['POST'])
@auth.oidc_auth
def delete(vmid):
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.rtp or int(vmid) in user.allowed_vms:
        q.enqueue(delete_vm_task, vmid)
        return '', 200
    else:
        return '', 403


@app.route("/vm/create", methods=['GET', 'POST'])
@auth.oidc_auth
def create():
    user = User(session['userinfo']['preferred_username'])
    proxmox = connect_proxmox()
    if user.active:
        if request.method == 'GET':
            isos = get_isos(proxmox, app.config['PROXMOX_ISO_STORAGE'])
            pools = get_pools(proxmox, db)
            templates = get_templates(db)
            return render_template(
                'create.html',
                user=user,
                usage=user.usage,
                limits=user.limits,
                percents=user.usage_percent,
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
            if not user.rtp:
                usage_check = user.check_usage(0, 0, disk)
                username = user.name
            else:
                usage_check = None
                username = request.form['user']
            if usage_check:
                return usage_check
            else:
                valid, available = check_hostname(starrs, name)
                if valid and available:
                    if template == 'none':
                        q.enqueue(
                            create_vm_task,
                            username,
                            name,
                            cores,
                            memory,
                            disk,
                            iso,
                            timeout=300)
                    else:
                        password = gen_password(16)
                        q.enqueue(
                            setup_template_task,
                            template,
                            name,
                            username,
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
        set_user_usage_limits(db, user, cpu, mem, disk)
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
    user = User(session['userinfo']['preferred_username'])
    if user.rtp:
        templates = get_templates(db)
        ignored_pools = get_ignored_pools(db)
        allowed_users = get_allowed_users(db)
        return render_template(
            'settings.html',
            user=user,
            templates=templates,
            ignored_pools=ignored_pools,
            allowed_users=allowed_users)
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


@app.route("/user/<string:user>/allow", methods=['POST', 'DELETE'])
@auth.oidc_auth
def allowed_users(user):
    if 'rtp' in session['userinfo']['groups']:
        if request.method == 'POST':
            add_allowed_user(db, user)
        elif request.method == "DELETE":
            delete_allowed_user(db, user)
        return '', 200
    else:
        return '', 403


@app.route("/console/cleanup", methods=['POST'])
def cleanup_vnc():
    if request.form['token'] == app.config['VNC_CLEANUP_TOKEN']:
        for target in get_vnc_targets():
            tunnel = next((tunnel for tunnel in ssh_tunnels
                           if tunnel.local_bind_port == int(target['port'])),
                          None)
            if tunnel:
                if not next((conn for conn in psutil.net_connections()
                             if conn.laddr[1] == int(target['port'])
                             and conn.status == 'ESTABLISHED'), None):
                    try:
                        tunnel.stop()
                    except:
                        pass
                    ssh_tunnels.remove(tunnel)
                    delete_vnc_target(target['port'])
        return '', 200
    else:
        return '', 403


@app.route('/template/<string:template_id>/disk')
@auth.oidc_auth
def template_disk(template_id):
    if template_id == 'none':
        return '0'
    return get_template_disk(db, template_id)


@app.route('/template/<string:template_id>/edit', methods=['POST'])
@auth.oidc_auth
def template_edit(template_id):
    if 'rtp' in session['userinfo']['groups']:
        name = request.form['name']
        username = request.form['username']
        password = request.form['password']
        disk = request.form['disk']
        set_template_info(db, template_id, name, username, password, disk)
        return '', 200
    else:
        return '', 403


@app.route("/logout")
@auth.oidc_logout
def logout():
    return redirect(url_for('list_vms'), 302)


def exit_handler():
    stop_websockify()
    for tunnel in ssh_tunnels:
        try:
            tunnel.stop()
        except:
            pass


atexit.register(exit_handler)

if __name__ == "__main__":
    app.run()
