import time
from proxmoxer import ProxmoxAPI


def connect_proxmox(host, user, password):
    try:
        proxmox = ProxmoxAPI(host, user=user, password=password, verify_ssl=False)
    except:
        print("Unable to connect to Proxmox!")
        raise
    return proxmox


def get_vms_for_user(proxmox, user):
    return proxmox.pools(user).get()['members']


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


def get_vm_disk_size(proxmox, vmid, config=None, name='virtio0'):
    if not config:
        config = get_vm_config(proxmox, vmid)
    disk_size = config[name].split(',')
    if 'size' in disk_size[0]:
        disk_size = disk_size[0].split('=')[1]
    else:
        disk_size = disk_size[1].split('=')[1]
    return disk_size


def create_vm(proxmox, starrs, user, name, cores, memory, disk):
    node = proxmox.nodes(get_node_least_mem(proxmox))
    vmid = get_free_vmid(proxmox)
    node.qemu.create(vmid=vmid, name=name, cores=cores, memory=memory, storage='ceph', virtio0='ceph:10', net0='virtio,bridge=vmbr0', pool=user)
    time.sleep(3)
    mac = get_vm_mac(proxmox, vmid)
    register_starrs(starrs, name, user, mac, get_next_ip(starrs, '49net Public Fixed')[0][0])
    return vmid

def delete_vm(proxmox, starrs, vmid, name):
    print(vmid)
    print(get_vm_node(proxmox, vmid))
    node = proxmox.nodes(get_vm_node(proxmox, vmid))
    node.qemu(vmid).delete()
    delete_starrs(starrs, name)
