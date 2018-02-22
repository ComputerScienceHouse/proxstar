import datetime
from sqlalchemy import exists
from dateutil.relativedelta import relativedelta
from proxstar.ldapdb import *
from proxstar.models import VM_Expiration, Usage_Limit, Pool_Cache, Ignored_Pools, Template, Allowed_Users, Base


def get_vm_expire(db, vmid, months):
    if db.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = db.query(VM_Expiration).filter(
            VM_Expiration.id == vmid).one().expire_date
    else:
        expire = datetime.date.today() + relativedelta(months=months)
        new_expire = VM_Expiration(id=vmid, expire_date=expire)
        db.add(new_expire)
        db.commit()
    return expire


def renew_vm_expire(db, vmid, months):
    if db.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = db.query(VM_Expiration).filter(VM_Expiration.id == vmid).one()
        new_expire = datetime.date.today() + relativedelta(months=months)
        expire.expire_date = new_expire
        db.commit()
    else:
        expire = datetime.date.today() + relativedelta(months=months)
        new_expire = VM_Expiration(id=vmid, expire_date=expire)
        db.add(new_expire)
        db.commit()


def delete_vm_expire(db, vmid):
    if db.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = db.query(VM_Expiration).filter(VM_Expiration.id == vmid).one()
        db.delete(expire)
        db.commit()


def get_expired_vms(db):
    expired = []
    today = datetime.date.today().strftime('%Y-%m-%d')
    expire = db.query(VM_Expiration).filter(
        VM_Expiration.expire_date < today).all()
    for vm in expire:
        expired.append(vm.id)
    return expired


def get_expiring_vms(db):
    expiring = []
    today = datetime.date.today()
    expire = db.query(VM_Expiration).filter(
        (VM_Expiration.expire_date - today) <= 10).all()
    for vm in expire:
        expiring.append(vm.id)
    return expiring


def get_user_usage_limits(db, user):
    limits = dict()
    if is_rtp(user):
        limits['cpu'] = 1000
        limits['mem'] = 1000
        limits['disk'] = 100000
    elif db.query(exists().where(Usage_Limit.id == user)).scalar():
        limits['cpu'] = db.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().cpu
        limits['mem'] = db.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().mem
        limits['disk'] = db.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().disk
    else:
        limits['cpu'] = 4
        limits['mem'] = 4
        limits['disk'] = 100
    return limits


def set_user_usage_limits(db, user, cpu, mem, disk):
    if db.query(exists().where(Usage_Limit.id == user)).scalar():
        limits = db.query(Usage_Limit).filter(Usage_Limit.id == user).one()
        limits.cpu = cpu
        limits.mem = mem
        limits.disk = disk
        db.commit()
    else:
        limits = Usage_Limit(id=user, cpu=cpu, mem=mem, disk=disk)
        db.add(limits)
        db.commit()


def delete_user_usage_limits(db, user):
    if db.query(exists().where(Usage_Limit.id == user)).scalar():
        limits = db.query(Usage_Limit).filter(Usage_Limit.id == user).one()
        db.delete(limits)
        db.commit()


def store_pool_cache(db, pools):
    db.query(Pool_Cache).delete()
    for pool in pools:
        pool_entry = Pool_Cache(
            pool=pool['user'],
            vms=pool['vms'],
            num_vms=pool['num_vms'],
            usage=pool['usage'],
            limits=pool['limits'],
            percents=pool['percents'])
        db.add(pool_entry)
    db.commit()


def get_pool_cache(db):
    db_pools = db.query(Pool_Cache).all()
    pools = []
    for pool in db_pools:
        pool_dict = dict()
        pool_dict['user'] = pool.pool
        pool_dict['vms'] = pool.vms
        pool_dict['num_vms'] = pool.num_vms
        pool_dict['usage'] = pool.usage
        pool_dict['limits'] = pool.limits
        pool_dict['percents'] = pool.percents
        pools.append(pool_dict)
    return pools


def get_ignored_pools(db):
    ignored_pools = []
    for pool in db.query(Ignored_Pools).all():
        ignored_pools.append(pool.id)
    return ignored_pools


def delete_ignored_pool(db, pool):
    if db.query(exists().where(Ignored_Pools.id == pool)).scalar():
        ignored_pool = db.query(Ignored_Pools).filter(
            Ignored_Pools.id == pool).one()
        db.delete(ignored_pool)
        db.commit()


def add_ignored_pool(db, pool):
    if not db.query(exists().where(Ignored_Pools.id == pool)).scalar():
        ignored_pool = Ignored_Pools(id=pool)
        db.add(ignored_pool)
        db.commit()


def get_templates(db):
    templates = []
    for template in db.query(Template).all():
        template_dict = dict()
        template_dict['id'] = template.id
        template_dict['name'] = template.name
        template_dict['username'] = template.username
        template_dict['password'] = template.password
        template_dict['disk'] = template.disk
        templates.append(template_dict)
    return templates


def get_template(db, template_id):
    template_dict = dict()
    if db.query(exists().where(Template.id == template_id)).scalar():
        template = db.query(Template).filter(Template.id == template_id).one()
        template_dict['id'] = template.id
        template_dict['name'] = template.name
        template_dict['username'] = template.username
        template_dict['password'] = template.password
        template_dict['disk'] = template.disk
    return template_dict


def get_template_disk(db, template_id):
    disk = 0
    if db.query(exists().where(Template.id == template_id)).scalar():
        template = db.query(Template).filter(Template.id == template_id).one()
        disk = template.disk
    return str(disk)


def get_allowed_users(db):
    allowed_users = []
    for user in db.query(Allowed_Users).all():
        allowed_users.append(user.id)
    return allowed_users


def add_allowed_user(db, user):
    if not db.query(exists().where(Allowed_Users.id == user)).scalar():
        allowed_user = Allowed_Users(id=user)
        db.add(allowed_user)
        db.commit()


def delete_allowed_user(db, user):
    if db.query(exists().where(Allowed_Users.id == user)).scalar():
        allowed_user = db.query(Allowed_Users).filter(
            Allowed_Users.id == user).one()
        db.delete(allowed_user)
        db.commit()
