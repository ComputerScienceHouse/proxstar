import time
from flask import current_app as app
from proxmoxer import ProxmoxAPI
from db import *


def connect_proxmox():
    try:
        proxmox = ProxmoxAPI(
            app.config['PROXMOX_HOST'], user=app.config['PROXMOX_USER'], password=app.config['PROXMOX_PASS'], verify_ssl=False)
    except:
        print("Unable to connect to Proxmox!")
        raise
    return proxmox


def get_vms_for_user(proxmox, user, rtp=False):
    pools = get_pools(proxmox)
    if not rtp:
        if user not in pools:
            proxmox.pools.post(poolid=user, comment='Managed by Proxstar')
        vms = proxmox.pools(user).get()['members']
        for vm in vms:
            if 'name' not in vm:
                vms.remove(vm)
        vms = sorted(vms, key=lambda k: k['name'])
        return vms
    else:
        pool_vms = []
        for pool in pools:
            vms = proxmox.pools(pool).get()['members']
            for vm in vms:
                if 'name' not in vm:
                    vms.remove(vm)
            vms = sorted(vms, key=lambda k: k['name'])
            pool_vms.append([pool, vms])
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
    if 'size' in disk_size[0]:
        disk_size = disk_size[0].split('=')[1].rstrip('G')
    else:
        disk_size = disk_size[1].split('=')[1].rstrip('G')
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
                if 'size' in disk_size[0]:
                    disk_size = disk_size[0].split('=')[1].rstrip('G')
                else:
                    disk_size = disk_size[1].split('=')[1].rstrip('G')
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
    vms = get_vms_for_user(proxmox, user)
    for vm in vms:
        config = get_vm_config(proxmox, vm['vmid'])
        if 'status' in vm:
            if vm['status'] == 'running' or vm['status'] == 'paused':
                usage['cpu'] += int(config['cores'] * config.get('sockets', 1))
                usage['mem'] += (int(config['memory']) // 1024)
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


def get_user_usage_percent(proxmox, usage=None, limits=None):
    percents = dict()
    if not usage:
        usage = get_user_usage(proxmox, user)
    if not limits:
        limits = get_user_usage_limits(user)
    percents['cpu'] = round(int(usage['cpu']) / int(limits['cpu']) * 100)
    percents['mem'] = round(int(usage['mem']) / int(limits['mem']) * 100)
    percents['disk'] = round(int(usage['disk']) / int(limits['disk']) * 100)
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
    time.sleep(3)
    mac = get_vm_mac(proxmox, vmid)
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
