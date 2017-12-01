import os
import time
import psycopg2
import subprocess
from starrs import *
from proxmox import *
from proxmoxer import ProxmoxAPI
from flask import Flask, render_template, request, redirect, send_from_directory

app = Flask(__name__)

config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")

app.config.from_pyfile(config)

app.config["GIT_REVISION"] = subprocess.check_output(
    ['git', 'rev-parse', '--short', 'HEAD']).decode('utf-8').rstrip()

user = 'proxstar'
proxmox = connect_proxmox(app.config['PROXMOX_HOST'],
                          app.config['PROXMOX_USER'],
                          app.config['PROXMOX_PASS'])
starrs = connect_starrs(
    app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'],
    app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS'])


@app.route("/")
def list_vms():
    vms = get_vms_for_user(proxmox, user)
    for vm in vms:
        if 'name' not in vm:
            vms.remove(vm)
        else:
            vm['config'] = get_vm_config(proxmox, vm['vmid'])
            vm['disk_size'] = get_vm_disk_size(
                proxmox, vm['vmid'], config=vm['config'])
    vms = sorted(vms, key=lambda k: k['name'])
    return render_template('list_vms.html', username='com6056', vms=vms)


@app.route("/vm/<string:vmid>")
def vm_details(vmid):
    vm = get_vm(proxmox, vmid)
    vm['vmid'] = vmid
    vm['config'] = get_vm_config(proxmox, vmid)
    vm['disks'] = get_vm_disks(proxmox, vmid, config=vm['config'])
    vm['interfaces'] = get_vm_interfaces(
        proxmox, vm['vmid'], config=vm['config'])
    return render_template('vm_details.html', username='com6056', vm=vm)


@app.route("/create")
def create():
    return render_template('create.html', username='com6056')


@app.route("/get_create", methods=['POST'])
def get_create():
    name = request.form['name']
    cores = request.form['cores']
    memory = request.form['memory']
    disk = request.form['disk']
    vmid, mac = create_vm(proxmox, starrs, user, name, cores, memory, disk)
    register_starrs(starrs, name, user, mac,
                    get_next_ip(starrs, '49net Public Fixed')[0][0])
    return redirect("/proxstar/vm/{}".format(vmid))


@app.route("/delete", methods=['POST'])
def delete():
    vmid = request.form['delete']
    vmname = get_vm_config(proxmox, vmid)['name']
    return render_template(
        'confirm_delete.html', username='com6056', vmid=vmid, vmname=vmname)


@app.route("/confirm_delete", methods=['POST'])
def confirm_delete():
    vmid = request.form['delete']
    vmname = get_vm_config(proxmox, vmid)['name']
    delete_vm(proxmox, starrs, vmid)
    delete_starrs(starrs, vmname)
    time.sleep(3)
    return redirect("/proxstar")


@app.route('/novnc/<path:path>')
def send_novnc(path):
    return send_from_directory('static/novnc-pve/novnc', path)


if __name__ == "__main__":
    app.run()
