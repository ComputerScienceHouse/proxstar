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


user = 'ram'
proxmox = connect_proxmox(app.config['PROXMOX_HOST'], app.config['PROXMOX_USER'], app.config['PROXMOX_PASS'])
starrs = connect_starrs(app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'], app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS'])
#print(get_vms_for_user(user))
#vmid = create_vm(proxmox, starrs, user, name)
#time.sleep(10)
#delete_vm(proxmox, starrs, vmid, name)


@app.route("/")
def get_vms():
    vms = get_vms_for_user(proxmox, user)
    for vm in vms:
        vm['config'] = get_vm_config(proxmox, vm['vmid'])
        vm['disk_size'] = get_vm_disk_size(proxmox, vm['vmid'], config=vm['config'])
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
    vmid = create_vm(proxmox, starrs, user, name, cores, memory, disk)
    print(vmid)
    return vmid 


if __name__ == "__main__":
    app.run()
