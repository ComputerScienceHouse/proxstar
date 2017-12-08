from db import *
from config import *
from starrs import *
from proxmox import *


def process_expired_vms():
    proxmox = connect_proxmox(PROXMOX_HOST, PROXMOX_USER, PROXMOX_PASS)
    starrs = connect_starrs(STARRS_DB_NAME, STARRS_DB_USER, STARRS_DB_HOST,
                            STARRS_DB_PASS)
    expired_vms = get_expired_vms()
    for vmid in expired_vms:
        vmname = get_vm_config(proxmox, vmid)['name']
        delete_vm(proxmox, starrs, vmid)
        delete_starrs(starrs, vmname)
        delete_vm_expire(vmid)


process_expired_vms()
