from math import ceil

from proxmoxer.core import ResourceException
from rq.registry import StartedJobRegistry

from proxstar.ldapdb import is_active, is_user, is_current_student
from proxstar import db, q, redis_conn
from proxstar.db import get_allowed_users, get_user_usage_limits, is_rtp, get_shared_pools
from proxstar.proxmox import connect_proxmox, get_pools
from proxstar.util import lazy_property, default_repr
from proxstar.vm import VM


@default_repr
class User:
    def __init__(self, username):
        self.name = username
        self.active = (
            is_active(self.name)
            or is_current_student(self.name)
            or self.name in get_allowed_users(db)
        )
        self.rtp = is_rtp(self.name)
        self.limits = get_user_usage_limits(db, self.name)

    @lazy_property
    def vms(self):
        proxmox = connect_proxmox()
        try:
            # try to get the users vms from their pool
            vms = proxmox.pools(self.name).get()['members']
        except ResourceException:
            # they likely don't have a pool yet, try to create it
            if is_user(self.name):
                proxmox.pools.post(poolid=self.name, comment='Managed by Proxstar')
                # if created, their pool is empty so return empty array
                return []
            else:
                return []
        for vm in vms:
            if 'name' not in vm:
                vms.remove(vm)
        vms = sorted(vms, key=lambda k: k['name'])

        return vms

    @lazy_property
    def pending_vms(self):
        jobs = StartedJobRegistry('default', connection=redis_conn).get_job_ids()
        for job_id in q.job_ids:
            jobs.append(job_id)
        pending_vms = []
        for job in jobs:
            job = q.fetch_job(job)
            if job and len(job.args) > 2:
                if self.name in (job.args[0], job.args[2]):
                    vm_dict = {}
                    vm_dict['name'] = job.args[1]
                    vm_dict['status'] = job.meta.get('status', 'no status yet')
                    vm_dict['pending'] = True
                    pending_vms.append(vm_dict)
        return pending_vms

    @lazy_property
    def allowed_vms(self):
        allowed_vms = []
        for vm in self.vms:
            allowed_vms.append(vm['vmid'])
        shared_pools = get_shared_pools(db, self.name, False)
        proxmox = connect_proxmox()
        for pool in shared_pools:
            vms = proxmox.pools(pool.name).get()['members']
            for vm in vms:
                allowed_vms.append(vm['vmid'])
        return allowed_vms

    @lazy_property
    def usage(self):
        usage = {}
        usage['cpu'] = 0
        usage['mem'] = 0
        usage['disk'] = 0
        if self.rtp:
            return usage
        vms = self.vms
        for vm in vms:
            if 'status' in vm:
                vm = VM(vm['vmid'])
                if vm.status in ('running', 'paused'):
                    usage['cpu'] += int(vm.cpu)
                    usage['mem'] += int(vm.mem) / 1024
                for disk in vm.disks:
                    usage['disk'] += int(ceil(float(disk[1])))
        return usage

    @lazy_property
    def usage_percent(self):
        percents = {}
        percents['cpu'] = round(self.usage['cpu'] / self.limits['cpu'] * 100)
        percents['mem'] = round(self.usage['mem'] / self.limits['mem'] * 100)
        percents['disk'] = round(self.usage['disk'] / self.limits['disk'] * 100)
        for resource in percents:
            if percents[resource] > 100:
                percents[resource] = 100
        return percents

    def check_usage(self, cpu, mem, disk):
        if int(self.usage['cpu']) + int(cpu) > int(self.limits['cpu']):
            return 'exceeds_cpu_limit'
        elif int(self.usage['mem']) + (int(mem) / 1024) > int(self.limits['mem']):
            return 'exceeds_memory_limit'
        elif int(self.usage['disk']) + int(disk) > int(self.limits['disk']):
            return 'exceeds_disk_limit'
        else:
            return None

    def delete(self):
        proxmox = connect_proxmox()
        proxmox.pools(self.name).delete()
        users = proxmox.access.users.get()
        if any(user['userid'] == '{}@csh.rit.edu'.format(self.name) for user in users):
            if (
                'rtp'
                not in proxmox.access.users('{}@csh.rit.edu'.format(self.name)).get()['groups']
            ):
                proxmox.access.users('{}@csh.rit.edu'.format(self.name)).delete()


def get_vms_for_rtp(proxmox, database):
    pools = []
    for pool in get_pools(proxmox, database):
        user = User(pool)
        pool_dict = {}
        pool_dict['user'] = user.name
        pool_dict['vms'] = user.vms
        pool_dict['num_vms'] = len(pool_dict['vms'])
        pool_dict['usage'] = user.usage
        pool_dict['limits'] = user.limits
        pool_dict['percents'] = user.usage_percent
        pools.append(pool_dict)
    return pools
