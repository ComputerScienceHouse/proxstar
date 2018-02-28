from proxstar.util import *
from proxstar.proxmox import *


class VM(object):
    def __init__(self, vmid):
        self.id = vmid

    @lazy_property
    def name(self):
        return self.config['name']

    @lazy_property
    def cpu(self):
        return self.config['cores']

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
        proxmox.nodes(self.node).qemu(self.id).config.put(cores=cores)
        self.cpu = cores

    def set_mem(self, mem):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(memory=mem)
        self.mem = mem

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

    def get_interfaces(self):
        interfaces = []
        for key, val in self.config.items():
            if 'net' in key:
                mac = self.config[key].split(',')
                valid_int_types = ['virtio', 'e1000', 'rtl8139', 'vmxnet3']
                if any(int_type in mac[0] for int_type in valid_int_types):
                    mac = mac[0].split('=')[1]
                else:
                    mac = mac[1].split('=')[1]
                interfaces.append([key, mac])
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

    def get_disks(self):
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

    def get_iso(self):
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
