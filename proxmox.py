import time
from functools import lru_cache
from proxmoxer import ProxmoxAPI
from flask import current_app as app
from db import *
from ldapdb import *


def connect_proxmox():
    try:
        proxmox = ProxmoxAPI(
            app.config['PROXMOX_HOST'],
            user=app.config['PROXMOX_USER'],
            password=app.config['PROXMOX_PASS'],
            verify_ssl=False)
    except:
        print("Unable to connect to Proxmox!")
        raise
    return proxmox


def create_user(proxmox, user):
    if not is_rtp(user):
        proxmox.pools.post(poolid=user, comment='Managed by Proxstar')
        users = proxmox.access.users.get()
        username = "{}@csh.rit.edu".format(user)
        proxmox.access.users.post(userid=username)
        proxmox.access.acl.put(
            path="/pool/{}".format(user), roles='PVEVMConsole', users=username)


def get_vms_for_user(proxmox, user):
    pools = get_pools(proxmox)
    if user not in pools:
        create_user(proxmox, user)
    vms = proxmox.pools(user).get()['members']
    for vm in vms:
        if 'name' not in vm:
            vms.remove(vm)
    vms = sorted(vms, key=lambda k: k['name'])
    return vms


def get_vms_for_rtp(proxmox):
    pools = get_pools(proxmox)
    pool_vms = []
    for pool in pools:
        pool_dict = dict()
        pool_dict['user'] = pool
        pool_dict['vms'] = get_vms_for_user(proxmox, pool)
        pool_dict['num_vms'] = len(pool_dict['vms'])
        pool_dict['usage'] = get_user_usage(proxmox, pool)
        pool_dict['limits'] = get_user_usage_limits(pool)
        pool_dict['percents'] = get_user_usage_percent(
            proxmox, pool, pool_dict['usage'], pool_dict['limits'])
        pool_vms.append(pool_dict)
    return pool_vms


def get_user_allowed_vms(proxmox, user):
    allowed_vms = []
    for vm in get_vms_for_user(proxmox, user):
        allowed_vms.append(vm['vmid'])
    return allowed_vms


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


def get_vm(proxmox, vmid):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    return node.qemu(vmid).status.current.get()


def get_vm_config(proxmox, vmid):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    return node.qemu(vmid).config.get()


def get_vm_mac(proxmox, vmid, config=None, interface='net0'):
    if not config:
        config = get_vm_config(proxmox, vmid)
    mac = config[interface].split(',')
    if 'virtio' in mac[0]:
        mac = mac[0].split('=')[1]
    else:
        mac = mac[1].split('=')[1]
    return mac


def get_vm_interfaces(proxmox, vmid, config=None):
    if not config:
        config = get_vm_config(proxmox, vmid)
    interfaces = []
    for key, val in config.items():
        if 'net' in key:
            mac = config[key].split(',')
            valid_int_types = ['virtio', 'e1000', 'rtl8139', 'vmxnet3']
            if any(int_type in mac[0] for int_type in valid_int_types):
                mac = mac[0].split('=')[1]
            else:
                mac = mac[1].split('=')[1]
            interfaces.append([key, mac])
    interfaces = sorted(interfaces, key=lambda x: x[0])
    return interfaces


def get_vm_disk_size(proxmox, vmid, config=None, name='virtio0'):
    if not config:
        config = get_vm_config(proxmox, vmid)
    disk_size = config[name].split(',')
    for split in disk_size:
        if 'size' in split:
            disk_size = split.split('=')[1].rstrip('G')
    return disk_size


def get_vm_disks(proxmox, vmid, config=None):
    if not config:
        config = get_vm_config(proxmox, vmid)
    disks = []
    for key, val in config.items():
        valid_disk_types = ['virtio', 'ide', 'sata', 'scsi']
        if any(disk_type in key for disk_type in valid_disk_types):
            if 'scsihw' not in key and 'cdrom' not in val:
                disk_size = val.split(',')
                for split in disk_size:
                    if 'size' in split:
                        disk_size = split.split('=')[1].rstrip('G')
                disks.append([key, disk_size])
    disks = sorted(disks, key=lambda x: x[0])
    return disks


def get_vm_iso(proxmox, vmid, config=None):
    if not config:
        config = get_vm_config(proxmox, vmid)
    if config.get('ide2'):
        if config['ide2'].split(',')[0] == 'none':
            iso = 'None'
        else:
            iso = config['ide2'].split(',')[0].split('/')[1]
    else:
        iso = 'None'
    return iso


def get_user_usage(proxmox, user):
    usage = dict()
    usage['cpu'] = 0
    usage['mem'] = 0
    usage['disk'] = 0
    if is_rtp(user):
        return usage
    vms = get_vms_for_user(proxmox, user)
    for vm in vms:
        config = get_vm_config(proxmox, vm['vmid'])
        if 'status' in vm:
            if vm['status'] == 'running' or vm['status'] == 'paused':
                usage['cpu'] += int(config['cores'] * config.get('sockets', 1))
                usage['mem'] += (int(config['memory']) / 1024)
            for disk in get_vm_disks(proxmox, vm['vmid'], config):
                usage['disk'] += int(disk[1])
    return usage


def check_user_usage(proxmox, user, vm_cpu, vm_mem, vm_disk):
    limits = get_user_usage_limits(user)
    cur_usage = get_user_usage(proxmox, user)
    if int(cur_usage['cpu']) + int(vm_cpu) > int(limits['cpu']):
        return 'exceeds_cpu_limit'
    elif int(cur_usage['mem']) + (int(vm_mem) / 1024) > int(limits['mem']):
        return 'exceeds_memory_limit'
    elif int(cur_usage['disk']) + int(vm_disk) > int(limits['disk']):
        return 'exceeds_disk_limit'


def get_user_usage_percent(proxmox, user, usage=None, limits=None):
    percents = dict()
    if not usage:
        usage = get_user_usage(proxmox, user)
    if not limits:
        limits = get_user_usage_limits(user)
    percents['cpu'] = round(usage['cpu'] / limits['cpu'] * 100)
    percents['mem'] = round(usage['mem'] / limits['mem'] * 100)
    percents['disk'] = round(usage['disk'] / limits['disk'] * 100)
    for resource in percents:
        if percents[resource] > 100:
            percents[resource] = 100
    return percents


def create_vm(proxmox, starrs, user, name, cores, memory, disk, iso):
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
            mac = get_vm_mac(proxmox, vmid)
            break
        except:
            retry += 1
            time.sleep(3)
    return vmid, mac


def delete_vm(proxmox, starrs, vmid):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).delete()


def change_vm_power(proxmox, vmid, action):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    if action == 'start':
        node.qemu(vmid).status.start.post()
    elif action == 'stop':
        node.qemu(vmid).status.stop.post()
    elif action == 'shutdown':
        node.qemu(vmid).status.shutdown.post()
    elif action == 'reset':
        node.qemu(vmid).status.reset.post()
    elif action == 'suspend':
        node.qemu(vmid).status.suspend.post()
    elif action == 'resume':
        node.qemu(vmid).status.resume.post()


def change_vm_cpu(proxmox, vmid, cores):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).config.put(cores=cores)


def change_vm_mem(proxmox, vmid, mem):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).config.put(memory=mem)


def get_isos(proxmox, storage):
    isos = []
    for iso in proxmox.nodes('proxmox01').storage(storage).content.get():
        isos.append(iso['volid'].split('/')[1])
    return isos


def eject_vm_iso(proxmox, vmid):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).config.post(ide2='none,media=cdrom')


def mount_vm_iso(proxmox, vmid, iso):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).config.post(ide2="{},media=cdrom".format(iso))


def get_pools(proxmox):
    pools = []
    for pool in proxmox.pools.get():
        poolid = pool['poolid']
        if poolid not in app.config['IGNORED_POOLS']:
            pools.append(poolid)
    pools = sorted(pools)
    return pools


def get_rrd_for_vm(proxmox, vmid, source, time):
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    image = node.qemu(vmid).rrd.get(ds=source, timeframe=time)['image']
    return image


def delete_user_pool(proxmox, pool):
    proxmox.pools(pool).delete()
    users = proxmox.access.users.get()
    if any(user['userid'] == "{}@csh.rit.edu".format(pool) for user in users):
        if 'rtp' not in proxmox.access.users(
                "{}@csh.rit.edu".format(pool)).get()['groups']:
            proxmox.access.users("{}@csh.rit.edu".format(pool)).delete()
