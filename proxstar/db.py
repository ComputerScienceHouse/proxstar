import datetime
from sqlalchemy import create_engine, exists
from sqlalchemy.orm import sessionmaker
from dateutil.relativedelta import relativedelta
from proxstar.ldapdb import *
from proxstar.db_init import VM_Expiration, Usage_Limit, Base

engine = create_engine('sqlite:///proxstar.db')
Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)
session = DBSession()


def get_vm_expire(vmid, months):
    if session.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = session.query(VM_Expiration).filter(
            VM_Expiration.id == vmid).one().expire_date
    else:
        expire = datetime.date.today() + relativedelta(months=months)
        new_expire = VM_Expiration(id=vmid, expire_date=expire)
        session.add(new_expire)
        session.commit()
    return expire


def renew_vm_expire(vmid, months):
    if session.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = session.query(VM_Expiration).filter(
            VM_Expiration.id == vmid).one()
        new_expire = datetime.date.today() + relativedelta(months=months)
        expire.expire_date = new_expire
        session.commit()
    else:
        expire = datetime.date.today() + relativedelta(months=months)
        new_expire = VM_Expiration(id=vmid, expire_date=expire)
        session.add(new_expire)
        session.commit()


def delete_vm_expire(vmid):
    if session.query(exists().where(VM_Expiration.id == vmid)).scalar():
        expire = session.query(VM_Expiration).filter(
            VM_Expiration.id == vmid).one()
        session.delete(expire)
        session.commit()


def get_expired_vms():
    expired = []
    today = datetime.date.today().strftime('%Y-%m-%d')
    expire = session.query(VM_Expiration).filter(
        VM_Expiration.expire_date < today).all()
    for vm in expire:
        expired.append(vm.id)
    return expired


def get_user_usage_limits(user):
    limits = dict()
    if is_rtp(user):
        limits['cpu'] = 1000
        limits['mem'] = 1000
        limits['disk'] = 100000
    elif session.query(exists().where(Usage_Limit.id == user)).scalar():
        limits['cpu'] = session.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().cpu
        limits['mem'] = session.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().mem
        limits['disk'] = session.query(Usage_Limit).filter(
            Usage_Limit.id == user).one().disk
    else:
        limits['cpu'] = 4
        limits['mem'] = 4
        limits['disk'] = 100
    return limits


def set_user_usage_limits(user, cpu, mem, disk):
    if session.query(exists().where(Usage_Limit.id == user)).scalar():
        limits = session.query(Usage_Limit).filter(
            Usage_Limit.id == user).one()
        limits.cpu = cpu
        limits.mem = mem
        limits.disk = disk
        session.commit()
    else:
        limits = Usage_Limit(id=user, cpu=cpu, mem=mem, disk=disk)
        session.add(limits)
        session.commit()


def delete_user_usage_limits(user):
    if session.query(exists().where(Usage_Limit.id == user)).scalar():
        limits = session.query(Usage_Limit).filter(
            Usage_Limit.id == user).one()
        session.delete(limits)
        session.commit()
