from flask import current_app as app
from proxmoxer import ProxmoxAPI

from proxstar import logging
from proxstar.db import get_ignored_pools
from proxstar.ldapdb import is_user


def connect_proxmox(host=None):
    if host:
        attempted_connection = attempt_proxmox_connection(host)
        if attempted_connection:
            return attempted_connection
        logging.error(f'unable to connect to {host}')
        raise

    for host in app.config['PROXMOX_HOSTS']:
        attempted_connection = attempt_proxmox_connection(host)
        if attempted_connection:
            return attempted_connection
    logging.error('unable to connect to any of the given Proxmox servers')
    raise


def attempt_proxmox_connection(host):
    try:
        proxmox = ProxmoxAPI(
            host,
            user=app.config['PROXMOX_USER'],
            token_name=app.config['PROXMOX_TOKEN_NAME'],
            token_value=app.config['PROXMOX_TOKEN_VALUE'],
            verify_ssl=False,
        )
        proxmox.version.get()
        return proxmox
    except:
        return None


def get_node_least_mem(proxmox):
    nodes = proxmox.nodes.get()
    sorted_nodes = sorted(nodes, key=lambda x: ('mem' not in x, x.get('mem', None)))
    return sorted_nodes[0]['node']


def get_free_vmid(proxmox):
    return proxmox.cluster.nextid.get()


def get_vm_node(proxmox, vmid):
    for vm in proxmox.cluster.resources.get(type='vm'):
        if vm['vmid'] == int(vmid):
            return vm['node']
    return None


def get_isos(proxmox, storage):
    isos = []
    first_node = app.config['PROXMOX_HOSTS'][0].split('.')[0]  # Get the name of the first node.
    for iso in proxmox.nodes(first_node).storage(storage).content.get():
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
