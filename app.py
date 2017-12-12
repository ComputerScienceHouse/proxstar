import os
import time
import psycopg2
import subprocess
from db import *
from starrs import *
from proxmox import *
from flask_pyoidc.flask_pyoidc import OIDCAuthentication
from flask import Flask, render_template, request, redirect, send_from_directory, session

app = Flask(__name__)

config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")

app.config.from_pyfile(config)

app.config["GIT_REVISION"] = subprocess.check_output(
    ['git', 'rev-parse', '--short', 'HEAD']).decode('utf-8').rstrip()

auth = OIDCAuthentication(
    app,
    issuer=app.config['OIDC_ISSUER'],
    client_registration_info=app.config['OIDC_CLIENT_CONFIG'])


@app.route("/")
@auth.oidc_auth
def list_vms():
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    vms = get_vms_for_user(proxmox, user, rtp)
    return render_template('list_vms.html', username=user, rtp=rtp, vms=vms)


@app.route("/isos")
@auth.oidc_auth
def isos():
    proxmox = connect_proxmox()
    isos = get_isos(proxmox, app.config['PROXMOX_ISO_STORAGE'])
    return ','.join(isos)


@app.route("/hostname/<string:name>")
@auth.oidc_auth
def hostname(name):
    starrs = connect_starrs()
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
    proxmox = connect_proxmox()
    starrs = connect_starrs()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
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
            vmid, app.config['VM_EXPIRE_MONTHS']).strftime('%m/%d/%Y')
        usage = get_user_usage(proxmox, 'proxstar')
        limits = get_user_usage_limits(user)
        usage_check = check_user_usage(proxmox, user, vm['config']['cores'],
                                       vm['config']['memory'], 0)
        return render_template(
            'vm_details.html',
            username=user,
            rtp=rtp,
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
    proxmox = connect_proxmox()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        if action == 'start':
            config = get_vm_config(proxmox, vmid)
            usage_check = check_user_usage(proxmox, user, config['cores'],
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
    proxmox = connect_proxmox()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        cur_cores = get_vm_config(proxmox, vmid)['cores']
        if cores >= cur_cores:
            status = get_vm(proxmox, vmid)['qmpstatus']
            if status == 'running' or status == 'paused':
                usage_check = check_user_usage(proxmox, user,
                                               cores - cur_cores, 0, 0)
            else:
                usage_check = check_user_usage(proxmox, user, cores, 0, 0)
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
    proxmox = connect_proxmox()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        cur_mem = get_vm_config(proxmox, vmid)['memory'] // 1024
        if mem >= cur_mem:
            status = get_vm(proxmox, vmid)['qmpstatus']
            if status == 'running' or status == 'paused':
                usage_check = check_user_usage(proxmox, user, 0, mem - cur_mem,
                                               0)
            else:
                usage_check = check_user_usage(proxmox, user, 0, mem, 0)
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
    proxmox = connect_proxmox()
    starrs = connect_starrs()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        renew_vm_expire(vmid, app.config['VM_EXPIRE_MONTHS'])
        for interface in get_vm_interfaces(proxmox, vmid):
            renew_ip(starrs, get_ip_for_mac(starrs, interface[1]))
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/eject", methods=['POST'])
@auth.oidc_auth
def iso_eject(vmid):
    user = session['userinfo']['preferred_username']
    proxmox = connect_proxmox()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        eject_vm_iso(proxmox, vmid)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/mount/<string:iso>", methods=['POST'])
@auth.oidc_auth
def iso_mount(vmid, iso):
    user = session['userinfo']['preferred_username']
    proxmox = connect_proxmox()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        iso = "{}:iso/{}".format(app.config['PROXMOX_ISO_STORAGE'], iso)
        mount_vm_iso(proxmox, vmid, iso)
        return '', 200
    else:
        return '', 403


@app.route("/vm/<string:vmid>/delete", methods=['POST'])
@auth.oidc_auth
def delete(vmid):
    user = session['userinfo']['preferred_username']
    proxmox = connect_proxmox()
    starrs = connect_starrs()
    if int(vmid) in get_user_allowed_vms(
            proxmox, user) or 'rtp' in session['userinfo']['groups']:
        vmname = get_vm_config(proxmox, vmid)['name']
        delete_vm(proxmox, starrs, vmid)
        delete_starrs(starrs, vmname)
        delete_vm_expire(vmid)
        return '', 200
    else:
        return '', 403


@app.route("/vm/create", methods=['GET', 'POST'])
@auth.oidc_auth
def create():
    user = session['userinfo']['preferred_username']
    rtp = 'rtp' in session['userinfo']['groups']
    proxmox = connect_proxmox()
    starrs = connect_starrs()
    if request.method == 'GET':
        usage = get_user_usage(proxmox, user)
        limits = get_user_usage_limits(user)
        percents = get_user_usage_percent(proxmox, usage, limits)
        isos = get_isos(proxmox, app.config['PROXMOX_ISO_STORAGE'])
        return render_template(
            'create.html',
            username=user,
            rtp=rtp,
            usage=usage,
            limits=limits,
            percents=percents,
            isos=isos)
    elif request.method == 'POST':
        name = request.form['name']
        cores = request.form['cores']
        memory = request.form['mem']
        disk = request.form['disk']
        iso = request.form['iso']
        if iso != 'none':
            iso = "{}:iso/{}".format(app.config['PROXMOX_ISO_STORAGE'], iso)
        usage_check = check_user_usage(proxmox, user, 0, 0, disk)
        if usage_check:
            return usage_check
        else:
            valid, available = check_hostname(starrs, name)
            if valid and available:
                vmid, mac = create_vm(proxmox, starrs, user, name, cores,
                                      memory, disk, iso)
                register_starrs(
                    starrs, name, app.config['STARRS_USER'], mac,
                    get_next_ip(starrs, app.config['STARRS_IP_RANGE'])[0][0])
                get_vm_expire(vmid, app.config['VM_EXPIRE_MONTHS'])
                return vmid


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


@app.route('/limits/<string:user>/reset', methods=['POST'])
@auth.oidc_auth
def reset_limits(user):
    if 'rtp' in session['userinfo']['groups']:
        delete_user_usage_limits(user)
        return '', 200
    else:
        return '', 403


@app.route('/limits')
@auth.oidc_auth
def limits():
    if 'rtp' in session['userinfo']['groups']:
        user = session['userinfo']['preferred_username']
        rtp = 'rtp' in session['userinfo']['groups']
        proxmox = connect_proxmox()
        pools = get_pools(proxmox)
        pools = sorted(pools)
        user_limits = []
        for pool in pools:
            if pool not in app.config['IGNORED_POOLS']:
                limits = get_user_usage_limits(pool)
                user_limits.append(
                    [pool, limits['cpu'], limits['mem'], limits['disk']])
        return render_template(
            'limits.html', username=user, rtp=rtp, user_limits=user_limits)
    else:
        return '', 403


@app.route('/novnc/<path:path>')
@auth.oidc_auth
def send_novnc(path):
    return send_from_directory('static/novnc-pve/novnc', path)


@app.route("/logout")
@auth.oidc_logout
def logout():
    return redirect(url_for('list_vms'), 302)


if __name__ == "__main__":
    app.run(debug=True)
