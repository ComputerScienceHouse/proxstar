import os
from db import *
from starrs import *
from proxmox import *
from flask import Flask, current_app

app = Flask(__name__)
config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)


def process_expired_vms():
    proxmox = connect_proxmox()
    starrs = connect_starrs()
    expired_vms = get_expired_vms()
    print(expired_vms)


#    for vmid in expired_vms:
#        vmname = get_vm_config(proxmox, vmid)['name']
#        delete_vm(proxmox, starrs, vmid)
#        delete_starrs(starrs, vmname)
#        delete_vm_expire(vmid)


def get_rrd_graphs():
    proxmox = connect_proxmox()
    pools = get_pools(proxmox)
    for pool in pools:
        vms = proxmox.pools(pool).get()['members']
        for vm in vms:
            vm_dir = "rrd/{}".format(vm['vmid'])
            if not os.path.exists(vm_dir):
                os.makedirs(vm_dir)
            sources = [
                'cpu', 'mem', 'netin', 'netout', 'diskread', 'diskwrite'
            ]
            for source in sources:
                image = get_rrd_for_vm(proxmox, vm['vmid'], source, 'day')
                with open("rrd/{}/{}.png".format(vm['vmid'], source),
                          'wb') as f:
                    f.write(image.encode('raw_unicode_escape'))


with app.app_context():
    process_expired_vms()
    get_rrd_graphs()
