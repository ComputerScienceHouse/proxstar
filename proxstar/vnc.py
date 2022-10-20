import os
import subprocess
import time
import urllib.parse

import requests
from flask import current_app as app

from proxstar import logging
from proxstar.util import gen_password


def stop_websockify():
    result = subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False)
    if result.stdout:
        pids = result.stdout.splitlines()
        for pid in pids:
            subprocess.run(['kill', pid], stdout=subprocess.PIPE, check=False)
            # FIXME (willnilges): Willard is lazy.
            time.sleep(1)
            if subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False).stdout:
                time.sleep(5)
                if subprocess.run(
                    ['pgrep', 'websockify'], stdout=subprocess.PIPE, check=False
                ).stdout:
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
            target_dict['host'] = f'{values[1].strip()}:{values[2]}'
            targets.append(target_dict)
        target_file.close()
    return targets


def add_vnc_target(node, port):
    # TODO (willnilges): This doesn't throw an error if the target file is wrong.
    targets = get_vnc_targets()
    target = next((target for target in targets if target['host'] == f'{node}:{port}'), None)
    if target:
        print('Host is already in the targets file')
        return target['token']
    else:
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'], 'a')
        token = gen_password(32, 'abcdefghijklmnopqrstuvwxyz0123456789')
        target_file.write(f'{token}: {node}:{port}\n')
        target_file.close()
        return token


def delete_vnc_target(node=None, port=None, token=None):
    targets = get_vnc_targets()
    if node is not None and port is not None:
        target = next((target for target in targets if target['host'] == f'{node}:{port}'), None)
    elif token is not None:
        target = next((target for target in targets if target['token'] == f'{token}'), None)
    else:
        raise ValueError('Need either a node and port, or a token.')
    if target:
        targets.remove(target)
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'], 'w')
        for target in targets:
            target_file.write(f"{target['token']}: {target['host']}\n")
        target_file.close()
    else:
        raise LookupError('Target does not exist')


def open_vnc_session(vmid, node, proxmox_user, proxmox_token_name, proxmox_token_value):
    """Pings the Proxmox API to request a VNC Proxy connection. Authenticates
    against the API using a Uname/Token, gets a few tokens back, then uses those
    tokens to  open the VNC Proxy. Use these to connect to the VM's host with
    websockify proxy.
    Returns: Ticket to use as the noVNC password, and a port.
    """
    # Get Proxmox API ticket and CSRF_Prevention_Token
    # TODO (willnilges): Use Proxmoxer to get this information
    # TODO (willnilges): Report errors
    proxy_params = {'node': node, 'vmid': str(vmid), 'websocket': '1', 'generate-password': '0'}
    vncproxy_response_data = requests.post(
        f'https://{node}.csh.rit.edu:8006/api2/json/nodes/{node}/qemu/{vmid}/vncproxy',
        verify=False,
        timeout=5,
        params=proxy_params,
        headers={'Authorization': f"PVEAPIToken={proxmox_user}!{proxmox_token_name}={proxmox_token_value}"},
    ).json()['data']

    return urllib.parse.quote_plus(vncproxy_response_data['ticket']), vncproxy_response_data['port']
