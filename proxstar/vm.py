import json
import urllib

from flask import current_app as app
from tenacity import retry, stop_after_attempt, wait_fixed

from proxstar import db, starrs
from proxstar.db import delete_vm_expire, get_vm_expire
from proxstar.proxmox import connect_proxmox, get_free_vmid, get_node_least_mem, get_vm_node
from proxstar.starrs import get_ip_for_mac
from proxstar.util import lazy_property, default_repr


@default_repr
class VM:
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

    def is_provisioned(self):
        try:
            self.set_cpu(self.cpu)
            return True
        except:
            return False

    @lazy_property
    def node(self):
        proxmox = connect_proxmox()
        for vm in proxmox.cluster.resources.get(type='vm'):
            if vm['vmid'] == int(self.id):
                return vm['node']
        return None

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def delete(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).delete()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_cpu(self, cores):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(cores=cores, sockets=1)

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_mem(self, mem):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(memory=mem)

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def start(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.start.post()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def stop(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.stop.post()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def shutdown(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.shutdown.post()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def reset(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.reset.post()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def suspend(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.suspend.post()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def resume(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).status.resume.post()

    @lazy_property
    def info(self):
        return self.get_info()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def get_info(self):
        proxmox = connect_proxmox()
        return proxmox.nodes(self.node).qemu(self.id).status.current.get()

    @lazy_property
    def config(self):
        return self.get_config()

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def get_config(self):
        proxmox = connect_proxmox()
        return proxmox.nodes(self.node).qemu(self.id).config.get()

    @lazy_property
    def boot_order(self):
        proxmox = connect_proxmox()
        boot_order_lookup = {'a': 'Floppy', 'c': 'Hard Disk', 'd': 'CD-ROM', 'n': 'Network'}
        raw_boot_order = self.config.get('boot', 'cdn')
        boot_order = {'legacy': False, 'order': []}
        try:
            # Proxmox version does not support 'order=' format
            if float(proxmox.nodes(self.node).version.get()['release']) < 6.3:
                boot_order['legacy'] = True
                for order in raw_boot_order:
                    boot_order['order'].append({'device': boot_order_lookup[order]})
            # Currently using 'order=' format
            elif raw_boot_order.startswith('order='):
                # Add enabled boot devices
                for order in raw_boot_order[6:].split(';'):
                    boot_order['order'].append(
                        {'device': order, 'description': self.config.get(order), 'enabled': True}
                    )
                # Add disabled boot devices
                enabled_devices = [order['device'] for order in boot_order['order']]
                for device in (
                    self.cdroms
                    + [disk[0] for disk in self.disks]
                    + [net[0] for net in self.interfaces]
                ):
                    if device not in enabled_devices:
                        boot_order['order'].append(
                            {
                                'device': device,
                                'description': self.config.get(device),
                                'enabled': False,
                            }
                        )
            # Currently using legacy format
            # Propose updating to the new format
            else:
                if raw_boot_order.startswith('legacy='):
                    raw_boot_order = raw_boot_order[7:]
                # Arrange boot devices according to current format
                devices = []
                for order in raw_boot_order:
                    if order == 'c':
                        disks = [disk[0] for disk in self.disks]
                        if self.config.get('bootdisk'):
                            boot_order.append(self.config['bootdisk'])
                            disks.remove(self.config['bootdisk'])
                        devices.extend(disks)
                    elif order == 'd':
                        devices.extend(self.cdroms)
                    elif order == 'n':
                        devices.extend([net[0] for net in self.interfaces])
                boot_order['order'].extend(
                    {'device': device, 'description': self.config.get(device), 'enabled': True}
                    for device in devices
                )
        except:
            return {'legacy': False, 'order': []}
        return boot_order

    @lazy_property
    def boot_order_json(self):
        return json.dumps(self.boot_order)

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_boot_order(self, boot_order):
        proxmox = connect_proxmox()
        boot_order_lookup = {'Floppy': 'a', 'Hard Disk': 'c', 'CD-ROM': 'd', 'Network': 'n'}
        # Check if legacy format
        if all(order in boot_order_lookup.keys() for order in boot_order):
            raw_boot_order = ''
            for order in boot_order:
                raw_boot_order += boot_order_lookup[order]
        else:
            raw_boot_order = f"order={';'.join(boot_order)}"
        proxmox.nodes(self.node).qemu(self.id).config.put(boot=raw_boot_order)

    @lazy_property
    def interfaces(self):
        interfaces = []
        for key, _ in self.config.items():
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
    def cdroms(self):
        cdroms = []
        valid_cdrom_types = ['ide', 'sata', 'scsi']
        for key, val in self.config.items():
            if any(type in key for type in valid_cdrom_types):
                if 'scsihw' not in key and 'cdrom' in val:
                    cdroms.append(key)
        cdroms = sorted(cdroms)
        return cdroms

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
            command='change vnc 127.0.0.1:{}'.format(port)
        )

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def eject_iso(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.post(ide2='none,media=cdrom')

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def mount_iso(self, iso):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.post(ide2='{},media=cdrom'.format(iso))

    def resize_disk(self, disk, size):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).resize.put(disk=disk, size='+{}G'.format(size))

    @lazy_property
    def expire(self):
        return get_vm_expire(db, self.id, app.config['VM_EXPIRE_MONTHS'])

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_ci_user(self, user):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(ciuser=user)

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_ci_ssh_key(self, ssh_key):
        proxmox = connect_proxmox()
        escaped_key = urllib.parse.quote(ssh_key, safe='')
        proxmox.nodes(self.node).qemu(self.id).config.put(sshkeys=escaped_key)

    @retry(wait=wait_fixed(2), stop=stop_after_attempt(5))
    def set_ci_network(self):
        proxmox = connect_proxmox()
        proxmox.nodes(self.node).qemu(self.id).config.put(ipconfig0='ip=dhcp')


# Will create a new VM with the given parameters, does not guarantee
# the VM is done provisioning when returning
def create_vm(proxmox, user, name, cores, memory, disk, iso):
    node = proxmox.nodes(get_node_least_mem(proxmox))
    vmid = get_free_vmid(proxmox)
    # Make sure lingering expirations are deleted
    delete_vm_expire(db, vmid)
    node.qemu.create(
        vmid=vmid,
        name=name,
        cores=cores,
        memory=memory,
        storage=app.config['PROXMOX_VM_STORAGE'],
        virtio0='{}:{}'.format(app.config['PROXMOX_VM_STORAGE'], disk),
        ide2='{},media=cdrom'.format(iso),
        net0='virtio,bridge=vmbr0',
        pool=user,
        description='Managed by Proxstar',
    )
    return vmid


# Will clone a new VM from a template, does not guarantee the
# VM is done provisioning when returning
def clone_vm(proxmox, template_id, name, pool):
    node = proxmox.nodes(get_vm_node(proxmox, template_id))
    vmid = get_free_vmid(proxmox)
    # Make sure lingering expirations are deleted
    delete_vm_expire(db, vmid)
    target = get_node_least_mem(proxmox)
    node.qemu(template_id).clone.post(
        newid=vmid, name=name, pool=pool, full=1, description='Managed by Proxstar', target=target
    )
    return vmid
