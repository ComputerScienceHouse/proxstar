import time
from proxmoxer import ProxmoxAPI
from proxstar.db import *
from proxstar.ldapdb import *


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


def get_vms_for_rtp(proxmox, db):
    pools = []
    for pool in get_pools(proxmox, db):
        pool_dict = dict()
        pool_dict['user'] = pool
        pool_dict['vms'] = get_vms_for_user(proxmox, db, pool)
        pool_dict['num_vms'] = len(pool_dict['vms'])
        pool_dict['usage'] = get_user_usage(proxmox, db, pool)
        pool_dict['limits'] = get_user_usage_limits(db, pool)
        pool_dict['percents'] = get_user_usage_percent(
            proxmox, pool, pool_dict['usage'], pool_dict['limits'])
        pools.append(pool_dict)
    return pools


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


def create_vm(proxmox, user, name, cores, memory, disk, iso):
    node = proxmox.nodes(get_node_least_mem(proxmox))
    vmid = get_free_vmid(proxmox)
    node.qemu.create(
        vmid=vmid,
        name=name,
        cores=cores,
        memory=memory,
        storage='ceph',
        virtio0="ceph:{}".format(disk),
        ide2="{},media=cdrom".format(iso),
        net0='virtio,bridge=vmbr0',
        pool=user,
        description='Managed by Proxstar')
    retry = 0
    while retry < 5:
        try:
            mac = VM(vmid).get_mac()
            break
        except:
            retry += 1
            time.sleep(3)
    return vmid, mac


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


def clone_vm(proxmox, template_id, name, pool):
    node = proxmox.nodes(get_vm_node(proxmox, template_id))
    newid = get_free_vmid(proxmox)
    target = get_node_least_mem(proxmox)
    node.qemu(template_id).clone.post(
        newid=newid,
        name=name,
        pool=pool,
        full=1,
        description='Managed by Proxstar',
        target=target)
    retry = 0
    while retry < 60:
        try:
            mac = VM(newid).get_mac()
            break
        except:
            retry += 1
            time.sleep(3)
    return newid, mac
