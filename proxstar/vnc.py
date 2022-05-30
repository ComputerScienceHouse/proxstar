import os
import subprocess
import time

import requests
from flask import current_app as app
from sshtunnel import SSHTunnelForwarder

from proxstar import logging
from proxstar.util import gen_password


def stop_websockify():
    result = subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False)
    if result.stdout:
        pid = result.stdout.strip()
        subprocess.run(['kill', pid], stdout=subprocess.PIPE, check=False)
        time.sleep(3)
        if subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False).stdout:
            time.sleep(10)
            if subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False).stdout:
                logging.info("websockify didn't stop, killing forcefully")
                subprocess.run(['kill', '-9', pid], stdout=subprocess.PIPE, check=False)


def get_vnc_targets():
    targets = []
    if os.path.exists(app.config['WEBSOCKIFY_TARGET_FILE']):
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'])
        for line in target_file:
            target_dict = {}
            values = line.strip().split(':')
            target_dict['token'] = values[0]
            target_dict['port'] = values[2]
            targets.append(target_dict)
        target_file.close()
    return targets


def add_vnc_target(port):
    targets = get_vnc_targets()
    target = next((target for target in targets if target['port'] == port), None)
    if target:
        return target['token']
    else:
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'], 'a')
        token = gen_password(32, 'abcdefghijklmnopqrstuvwxyz0123456789')
        target_file.write('{}: 127.0.0.1:{}\n'.format(token, str(port)))
        target_file.close()
        return token


def delete_vnc_target(port):
    targets = get_vnc_targets()
    target = next((target for target in targets if target['port'] == str(port)), None)
    if target:
        targets.remove(target)
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'], 'w')
        for target in targets:
            target_file.write('{}: 127.0.0.1:{}\n'.format(target['token'], target['port']))
        target_file.close()


def start_ssh_tunnel(node, port):
    port = int(port)
    server = SSHTunnelForwarder(
        node,
        ssh_username=app.config['PROXMOX_SSH_USER'],
        ssh_pkey='proxmox_ssh_key',
        ssh_private_key_password=app.config['PROXMOX_SSH_KEY_PASS'],
        remote_bind_address=('127.0.0.1', port),
        local_bind_address=('127.0.0.1', port),
    )
    server.start()
    return server


def stop_ssh_tunnel(vmid, ssh_tunnels):
    # Tear down the SSH tunnel and VNC target entry for a given VM
    port = 5900 + int(vmid)
    tunnel = next((tunnel for tunnel in ssh_tunnels if tunnel.local_bind_port == port), None)
    if tunnel:
        logging.info('tearing down SSH tunnel for VM %s', vmid)
        try:
            tunnel.stop()
        except:
            pass
        ssh_tunnels.remove(tunnel)
        delete_vnc_target(port)


def send_stop_ssh_tunnel(vmid):
    requests.post(
        'https://{}/console/vm/{}/stop'.format(app.config['SERVER_NAME'], vmid),
        data={'token': app.config['VNC_CLEANUP_TOKEN']},
        verify=False,
    )
