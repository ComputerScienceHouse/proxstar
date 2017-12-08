from sqlalchemy import create_engine, exists
from sqlalchemy.orm import sessionmaker
from dateutil.relativedelta import relativedelta
import datetime

from db_init import VM_Expiration, Base

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


#for entry in session.query(VM_Expiration).all():
#    print(entry.id, entry.expire_date)
#expiry = session.query(VM_Expiration).filter(VM_Expiration.id == 100).one()
#print(expiry.expire_date)
