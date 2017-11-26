import os
import time
import psycopg2
from starrs import *
from proxmox import *
from proxmoxer import ProxmoxAPI
from flask import Flask, render_template, request


app = Flask(__name__)


config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")


app.config.from_pyfile(config)


user = 'proxstar'
proxmox = connect_proxmox(app.config['PROXMOX_HOST'], app.config['PROXMOX_USER'], app.config['PROXMOX_PASS'])
starrs = connect_starrs(app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'], app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS'])


@app.route("/")
def get_vms():
    vms = get_vms_for_user(proxmox, user)
    for vm in vms:
        vm['config'] = get_vm_config(proxmox, vm['vmid'])
        vm['disk_size'] = get_vm_disk_size(proxmox, vm['vmid'], config=vm['config'])
        print(vm)
    return render_template('get_vms.html', vms=vms)


@app.route("/create")
def create():
    return render_template('create.html')


@app.route("/get_create", methods=['POST'])
def get_create():
    name = request.form['name']
    cores = request.form['cores']
    memory = request.form['memory']
    disk = request.form['disk']
    print(name, cores, memory, disk)
    vmid, mac = create_vm(proxmox, starrs, user, name, cores, memory, disk)
    print(register_starrs(starrs, name, user, mac, get_next_ip(starrs, '49net Public Fixed')[0][0]))
    print(vmid)
    return vmid


@app.route("/delete", methods=['POST'])
def delete():
    vmid = request.form['delete']
    vmname = get_vm_config(proxmox, vmid)['name']
    return render_template('confirm_delete.html', vmid=vmid, vmname=vmname)


@app.route("/confirm_delete", methods=['POST'])
def confirm_delete():
    vmid = request.form['delete']
    vmname = get_vm_config(proxmox, vmid)['name']
    delete_vm(proxmox, starrs, vmid)
    print(delete_starrs(starrs, vmname))
    return 'SUCCESS'


if __name__ == "__main__":
    app.run()
