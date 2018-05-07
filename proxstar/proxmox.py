from proxmoxer import ProxmoxAPI
from proxstar.ldapdb import is_user
from proxstar.db import get_user_usage_limits, get_ignored_pools
from flask import current_app as app


def connect_proxmox():
    for host in app.config['PROXMOX_HOSTS']:
        try:
            proxmox = ProxmoxAPI(
                host,
                user=app.config['PROXMOX_USER'],
                password=app.config['PROXMOX_PASS'],
                verify_ssl=False)
            version = proxmox.version.get()
            return proxmox
        except:
            if app.config['PROXMOX_HOSTS'].index(host) == (
                    len(app.config['PROXMOX_HOSTS']) - 1):
                print('Unable to connect to any of the given Proxmox servers!')
                raise


def connect_proxmox_ssh():
    for host in app.config['PROXMOX_HOSTS']:
        try:
            proxmox = ProxmoxAPI(
                host,
                user=app.config['PROXMOX_SSH_USER'],
                private_key_file='proxmox_ssh_key',
                password=app.config['PROXMOX_SSH_KEY_PASS'],
                backend='ssh_paramiko')
            version = proxmox.version.get()
            return proxmox
        except:
            if app.config['PROXMOX_HOSTS'].index(host) == (
                    len(app.config['PROXMOX_HOSTS']) - 1):
                print('Unable to connect to any of the given Proxmox servers!')
                raise


def get_node_least_mem(proxmox):
    nodes = proxmox.nodes.get()
    sorted_nodes = sorted(nodes, key=lambda x: x['mem'])
    return sorted_nodes[0]['node']


def get_free_vmid(proxmox):
    return proxmox.cluster.nextid.get()


def get_vm_node(proxmox, vmid):
    for vm in proxmox.cluster.resources.get(type='vm'):
        if vm['vmid'] == int(vmid):
            return vm['node']


def get_isos(proxmox, storage):
    isos = []
    for iso in proxmox.nodes('proxmox01').storage(storage).content.get():
        isos.append(iso['volid'].split('/')[1])
    return isos


def get_pools(proxmox, db):
    ignored_pools = get_ignored_pools(db)
    pools = []
    for pool in proxmox.pools.get():
        poolid = pool['poolid']
        if poolid not in ignored_pools and is_user(poolid):
            pools.append(poolid)
    pools = sorted(pools)
    return pools
