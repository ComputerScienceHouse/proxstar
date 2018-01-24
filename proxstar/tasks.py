import os
from flask import Flask
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from proxstar.db import *
from proxstar.starrs import *
from proxstar.proxmox import *

app = Flask(__name__)
if os.path.exists(
        os.path.join(
            app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")):
    config = os.path.join(
        app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")
else:
    config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)


def connect_db():
    engine = create_engine(app.config['SQLALCHEMY_DATABASE_URI'])
    Base.metadata.bind = engine
    DBSession = sessionmaker(bind=engine)
    db = DBSession()
    return db


def connect_starrs():
    starrs = psycopg2.connect(
        "dbname='{}' user='{}' host='{}' password='{}'".format(
            app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'],
            app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS']))
    return starrs


def create_vm_task(user, name, cores, memory, disk, iso):
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        starrs = connect_starrs()
        vmid, mac = create_vm(proxmox, user, name, cores, memory, disk, iso)
        register_starrs(starrs, name, app.config['STARRS_USER'], mac,
                        get_next_ip(starrs,
                                    app.config['STARRS_IP_RANGE'])[0][0])
        get_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])


def delete_vm_task(vmid):
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        starrs = connect_starrs()
        vmname = get_vm_config(proxmox, vmid)['name']
        delete_vm(proxmox, vmid)
        delete_starrs(starrs, vmname)
        delete_vm_expire(db, vmid)


def process_expired_vms_task():
    with app.app_context():
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        expired_vms = get_expired_vms()
        print(expired_vms)

    #    for vmid in expired_vms:
    #        vmname = get_vm_config(proxmox, vmid)['name']
    #        delete_vm(proxmox, starrs, vmid)
    #        delete_starrs(starrs, vmname)
    #        delete_vm_expire(vmid)
