import os
import subprocess
import time

import requests
from flask import current_app as app
from sshtunnel import SSHTunnelForwarder
import urllib.parse

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
            target_dict['host'] = f'{values[1].strip()}:{values[2]}'
            targets.append(target_dict)
        target_file.close()
    return targets


def add_vnc_target(node, port):
    # TODO (willnilges): This doesn't throw an error if the target file is wrong.
    # TODO (willnilges): This will duplicate targets
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


def delete_vnc_target(node, port):
    targets = get_vnc_targets()
    target = next((target for target in targets if target['host'] == f'{node}:{port}'), None)
    if target:
        targets.remove(target)
        target_file = open(app.config['WEBSOCKIFY_TARGET_FILE'], 'w')
        for target in targets:
            target_file.write(f"{target['token']}: {target['host']}\n")
        target_file.close()


def open_vnc_session(vmid, node, proxmox_user, proxmox_pass):
    """Pings the Proxmox API to request a VNC Proxy connection. Authenticates
    against the API using a Uname/Pass, gets a few tokens back, then uses those
    tokens to  open the VNC Proxy. Use these to connect to the VM's host with
    websockify proxy.
    Returns: Ticket to use as the noVNC password, and a port.
    """
    # Get Proxmox API ticket and CSRF_Prevention_Token
    # TODO (willnilges): Use Proxmoxer to get this information
    # TODO (willnilges): Report errors
    data = {"username": proxmox_user, "password": proxmox_pass}
    response_data = requests.post(
        f"https://{node}.csh.rit.edu:8006/" + "api2/json/access/ticket",
        verify=False,
        data=data,
    ).json()["data"]
    if response_data is None:
        raise AuthenticationError(
            "Could not authenticate against `ticket` endpoint! Check uname/password"
        )
    csrf_prevention_token = response_data['CSRFPreventionToken']
    ticket = response_data['ticket']
    proxy_params = {"node": node, "vmid": str(vmid), "websocket": '1', "generate-password": '0'}
    vncproxy_response_data = requests.post(
        f"https://{node}.csh.rit.edu:8006/api2/json/nodes/{node}/qemu/{vmid}/vncproxy",
        verify=False,
        timeout=5,
        params=proxy_params,
        headers={"CSRFPreventionToken": csrf_prevention_token},
        cookies={"PVEAuthCookie": ticket},
    ).json()["data"]

    return urllib.parse.quote_plus(vncproxy_response_data['ticket']), vncproxy_response_data['port']


def start_ssh_tunnel(node, port):
    """Forwards a port on a node
    to the proxstar container
    """
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
