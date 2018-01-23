import os
from proxstar.db import *
from proxstar.starrs import *
from proxstar.proxmox import *
from flask import Flask, current_app

app = Flask(__name__)
config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)


def create_vm_task(user, name, cores, memory, disk, iso):
    with app.app_context():
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        vmid, mac = create_vm(proxmox, starrs, user, name, cores, memory, disk,
                              iso)
        register_starrs(starrs, name, app.config['STARRS_USER'], mac,
                        get_next_ip(starrs,
                                    app.config['STARRS_IP_RANGE'])[0][0])
        get_vm_expire(vmid, app.config['VM_EXPIRE_MONTHS'])


def delete_vm_task(vmid):
    with app.app_context():
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        vmname = get_vm_config(proxmox, vmid)['name']
        delete_vm(proxmox, starrs, vmid)
        delete_starrs(starrs, vmname)
        delete_vm_expire(vmid)


def process_expired_vms_task():
    with app.app_context():
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        expired_vms = get_expired_vms()
        print(expired_vms)
    
    #    for vmid in expired_vms:
    #        vmname = get_vm_config(proxmox, vmid)['name']
    #        delete_vm(proxmox, starrs, vmid)
    #        delete_starrs(starrs, vmname)
    #        delete_vm_expire(vmid)
