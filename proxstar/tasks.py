import os
import time
import requests
import paramiko
import psycopg2
from flask import Flask
from rq import get_current_job
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from proxstar.db import *
from proxstar.util import *
from proxstar.mail import *
from proxstar.starrs import *
from proxstar.vm import VM, create_vm, clone_vm
from proxstar.user import User, get_vms_for_rtp
from proxstar.proxmox import connect_proxmox, get_pools

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
        job = get_current_job()
        proxmox = connect_proxmox()
        db = connect_db()
        starrs = connect_starrs()
        job.meta['status'] = 'creating VM'
        job.save_meta()
        vmid, mac = create_vm(proxmox, user, name, cores, memory, disk, iso)
        job.meta['status'] = 'registering in STARRS'
        job.save_meta()
        register_starrs(starrs, name, app.config['STARRS_USER'], mac,
                        get_next_ip(starrs, app.config['STARRS_IP_RANGE']))
        job.meta['status'] = 'setting VM expiration'
        job.save_meta()
        get_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])
        job.meta['status'] = 'complete'
        job.save_meta()


def delete_vm_task(vmid):
    with app.app_context():
        db = connect_db()
        starrs = connect_starrs()
        vm = VM(vmid)
        vm.delete()
        delete_starrs(starrs, vm.name)
        delete_vm_expire(db, vmid)


def process_expired_vms_task():
    with app.app_context():
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        expired_vms = get_expired_vms()
        print(expired_vms)

    #    for vmid in expired_vms:

    #        vm = VM(vmid)
    #        delete_vm(proxmox, starrs, vmid)
    #        delete_starrs(starrs, vm.name)
    #        delete_vm_expire(vmid)


def process_expiring_vms_task():
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        starrs = connect_starrs()
        pools = get_pools(proxmox, db)
        for pool in pools:
            user = User(pool)
            expiring_vms = []
            vms = user.vms
            for vm in vms:
                vm = VM(vm['vmid'])
                days = (vm.expire - datetime.date.today()).days
                if days in [10, 7, 3, 1, 0]:
                    name = vm.name
                    expiring_vms.append([vm.name, days])
                    if days == 0:
                        vm.stop()
            if expiring_vms:
                send_vm_expire_email('com6056', expiring_vms)


def generate_pool_cache_task():
    with app.app_context():
        proxmox = connect_proxmox()
        db = connect_db()
        pools = get_vms_for_rtp(proxmox, db)
        store_pool_cache(db, pools)


def setup_template_task(template_id, name, user, password, cores, memory):
    with app.app_context():
        job = get_current_job()
        proxmox = connect_proxmox()
        starrs = connect_starrs()
        db = connect_db()
        print("[{}] Retrieving template info for template {}.".format(
            name, template_id))
        template = get_template(db, template_id)
        print("[{}] Cloning template {}.".format(name, template_id))
        job.meta['status'] = 'cloning template'
        job.save_meta()
        vmid, mac = clone_vm(proxmox, template_id, name, user)
        print("[{}] Registering in STARRS.".format(name))
        job.meta['status'] = 'registering in STARRS'
        job.save_meta()
        ip = get_next_ip(starrs, app.config['STARRS_IP_RANGE'])
        register_starrs(starrs, name, app.config['STARRS_USER'], mac, ip)
        get_vm_expire(db, vmid, app.config['VM_EXPIRE_MONTHS'])
        print("[{}] Setting CPU and memory.".format(name))
        job.meta['status'] = 'setting CPU and memory'
        job.save_meta()
        vm = VM(vmid)
        vm.set_cpu(cores)
        vm.set_mem(memory)
        print(
            "[{}] Waiting for STARRS to propogate before starting VM.".format(
                name))
        job.meta['status'] = 'waiting for STARRS'
        job.save_meta()
        time.sleep(90)
        print("[{}] Starting VM.".format(name))
        job.meta['status'] = 'starting VM'
        job.save_meta()
        vm.start()
        print("[{}] Waiting for VM to start before SSHing.".format(name))
        job.meta['status'] = 'waiting for VM to start'
        job.save_meta()
        time.sleep(20)
        print("[{}] Creating SSH session.".format(name))
        job.meta['status'] = 'creating SSH session'
        job.save_meta()
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
        print("[{}] Running user creation commands.".format(name))
        job.meta['status'] = 'running user creation commands'
        job.save_meta()
        stdin, stdout, stderr = client.exec_command("useradd {}".format(user))
        exit_status = stdout.channel.recv_exit_status()
        root_password = gen_password(32)
        stdin, stdout, stderr = client.exec_command(
            "echo '{}' | passwd root --stdin".format(root_password))
        exit_status = stdout.channel.recv_exit_status()
        stdin, stdout, stderr = client.exec_command(
            "echo '{}' | passwd '{}' --stdin".format(password, user))
        exit_status = stdout.channel.recv_exit_status()
        stdin, stdout, stderr = client.exec_command(
            "passwd -e '{}'".format(user))
        exit_status = stdout.channel.recv_exit_status()
        stdin, stdout, stderr = client.exec_command(
            "echo '{} ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo".format(
                user))
        exit_status = stdout.channel.recv_exit_status()
        client.close()
        print("[{}] Template successfully provisioned.".format(name))
        job.meta['status'] = 'completed'
        job.save_meta()


def cleanup_vnc_task():
    requests.post(
        "https://{}/console/cleanup".format(app.config['SERVER_NAME']),
        data={'token': app.config['VNC_CLEANUP_TOKEN']},
        verify=False)
