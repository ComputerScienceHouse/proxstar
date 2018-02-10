import os
import pickle
pickle.HIGHEST_PROTOCOL = 2
import paramiko
from rq import Queue
from redis import Redis
from flask import Flask
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from proxstar.db import *
from proxstar.util import *
from proxstar.mail import *
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

redis_conn = Redis(app.config['REDIS_HOST'], app.config['REDIS_PORT'])
q = Queue(connection=redis_conn)


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
                        get_next_ip(starrs, app.config['STARRS_IP_RANGE']))
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


def process_expiring_vms_task():
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        starrs = connect_starrs()
        pools = get_pools(proxmox, db)
        for pool in pools:
            expiring_vms = []
            vms = get_vms_for_user(proxmox, db, pool)
            for vm in vms:
                vmid = vm['vmid']
                expire = get_vm_expire(db, vmid,
                                       app.config['VM_EXPIRE_MONTHS'])
                days = (expire - datetime.date.today()).days
                if days in [10, 7, 3, 1, 0]:
                    name = get_vm_config(proxmox, vmid)['name']
                    expiring_vms.append([name, days])
                    if days == 0:
                        #change_vm_power(proxmox, vmid, 'stop')
                        pass
            if expiring_vms:
                send_vm_expire_email('com6056', expiring_vms)


def generate_pool_cache_task():
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        pools = get_vms_for_rtp(proxmox, db)
        store_pool_cache(db, pools)


def setup_template(template_id, name, user, password, cores, memory):
    with app.app_context():
        q = Queue('ssh', connection=redis_conn)
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        db = connect_db()
        template = get_template(db, template_id)
        vmid, mac = clone_vm(proxmox, template_id, name, user)
        ip = get_next_ip(starrs, app.config['STARRS_IP_RANGE'])
        register_starrs(starrs, name, app.config['STARRS_USER'], mac, ip)
        get_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])
        change_vm_cpu(proxmox, vmid, cores)
        change_vm_mem(proxmox, vmid, memory)
        time.sleep(90)
        change_vm_power(proxmox, vmid, 'start')
        time.sleep(20)
        q.enqueue(setup_template_ssh, ip, template, user, password)


def setup_template_ssh(ip, template, user, password):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    retry = 0
    while retry < 30:
        try:
            client.connect(
                ip,
                username=template['username'],
                password=template['password'])
            break
        except:
            retry += 1
            time.sleep(3)
    stdin, stdout, stderr = client.exec_command("useradd {}".format(user))
    exit_status = stdout.channel.recv_exit_status()
    root_password = gen_password(32)
    stdin, stdout, stderr = client.exec_command(
        "echo '{}' | passwd root --stdin".format(root_password))
    exit_status = stdout.channel.recv_exit_status()
    stdin, stdout, stderr = client.exec_command(
        "echo '{}' | passwd '{}' -e --stdin".format(password, user))
    exit_status = stdout.channel.recv_exit_status()
    stdin, stdout, stderr = client.exec_command(
        "echo '{} ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo".format(
            user))
    exit_status = stdout.channel.recv_exit_status()
    client.close()
