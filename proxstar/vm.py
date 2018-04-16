import time
import json
from proxstar import db, starrs
from proxstar.db import get_vm_expire
from proxstar.util import lazy_property
from proxstar.starrs import get_ip_for_mac
from proxstar.proxmox import connect_proxmox, get_node_least_mem, get_free_vmid, get_vm_node
from flask import current_app as app


class VM(object):
    def __init__(self, vmid):
        self.id = vmid

    @lazy_property
    def name(self):
        try:
            return self.config['name']
        except KeyError:
            return self.id

    @lazy_property
    def cpu(self):
        return self.config['cores'] * self.config.get('sockets', 1)

    @lazy_property
    def mem(self):
        return self.config['memory']

    @lazy_property
    def status(self):
        return self.info['status']

    @lazy_property
    def qmpstatus(self):
        return self.info['qmpstatus']

    @lazy_property
    def node(self):
        proxmox = connect_proxmox()
        for vm in proxmox.cluster.resources.get(type='vm'):
            if vm['vmid'] == int(self.id):
                return vm['node']

    def delete(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).delete()

    def set_cpu(self, cores):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(
            cores=cores, sockets=1)

    def set_mem(self, mem):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(memory=mem)

    def start(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.start.post()

    def stop(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.stop.post()

    def shutdown(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.shutdown.post()

    def reset(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.reset.post()

    def suspend(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.suspend.post()

    def resume(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.resume.post()

    @lazy_property
    def info(self):
        proxmox = connect_proxmox()
        return proxmox.nodes(self.node).qemu(self.id).status.current.get()

    @lazy_property
    def config(self):
        proxmox = connect_proxmox()
        return proxmox.nodes(self.node).qemu(self.id).config.get()

    @lazy_property
    def boot_order(self):
        boot_order_lookup = {
            'a': 'Floppy',
            'c': 'Hard Disk',
            'd': 'CD-ROM',
            'n': 'Network'
        }
        raw_boot_order = self.config.get('boot', 'cdn')
        boot_order = []
        for i in range(0, len(raw_boot_order)):
            boot_order.append(boot_order_lookup[raw_boot_order[i]])
        return boot_order

    @lazy_property
    def boot_order_json(self):
        return json.dumps(self.boot_order)

    def set_boot_order(self, boot_order):
        proxmox = connect_proxmox()
        boot_order_lookup = {
            'Floppy': 'a',
            'Hard Disk': 'c',
            'CD-ROM': 'd',
            'Network': 'n'
        }
        raw_boot_order = ''
        for i in range(0, len(boot_order)):
            raw_boot_order += boot_order_lookup[boot_order[i]]
        proxmox.nodes(self.node).qemu(self.id).config.put(boot=raw_boot_order)

    @lazy_property
    def interfaces(self):
        interfaces = []
        for key, val in self.config.items():
            if 'net' in key:
                mac = self.config[key].split(',')
                valid_int_types = ['virtio', 'e1000', 'rtl8139', 'vmxnet3']
                if any(int_type in mac[0] for int_type in valid_int_types):
                    mac = mac[0].split('=')[1]
                else:
                    mac = mac[1].split('=')[1]
                ip = get_ip_for_mac(starrs, mac)
                interfaces.append([key, mac, ip])
        interfaces = sorted(interfaces, key=lambda x: x[0])
        return interfaces

    def get_mac(self, interface='net0'):
        mac = self.config[interface].split(',')
        if 'virtio' in mac[0]:
            mac = mac[0].split('=')[1]
        else:
            mac = mac[1].split('=')[1]
        return mac

    def get_disk_size(self, name='virtio0'):
        disk_size = self.config[name].split(',')
        for split in disk_size:
            if 'size' in split:
                disk_size = split.split('=')[1].rstrip('G')
        return disk_size

    @lazy_property
    def disks(self):
        disks = []
        for key, val in self.config.items():
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

    @lazy_property
    def iso(self):
        if self.config.get('ide2'):
            if self.config['ide2'].split(',')[0] == 'none':
                iso = 'None'
            else:
                iso = self.config['ide2'].split(',')[0].split('/')[1]
        else:
            iso = 'None'
        return iso

    def start_vnc(self, port):
        proxmox = connect_proxmox()
        port = str(int(port) - 5900)
        proxmox.nodes(self.node).qemu(self.id).monitor.post(
            command="change vnc 127.0.0.1:{}".format(port))

    def eject_iso(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(
            self.id).config.post(ide2='none,media=cdrom')

    def mount_iso(self, iso):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(
            self.id).config.post(ide2="{},media=cdrom".format(iso))

    def resize_disk(self, disk, size):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).resize.put(
            disk=disk, size="+{}G".format(size))

    @lazy_property
    def expire(self):
        return get_vm_expire(db, self.id, app.config['VM_EXPIRE_MONTHS'])


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
