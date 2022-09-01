import os
import subprocess

from flask import Flask
app = Flask(__name__)
if os.path.exists(os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config_local.py")):
    config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config_local.py")
else:
    config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)

timeout = app.config['TIMEOUT']


def start_websockify(websockify_path, target_file):
    result = subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE)
    if not result.stdout:
        print("Websockify is stopped. Starting websockify.")
        proxstar_port = app.config.get('WEBSOCKIFY_PORT')
        subprocess.call(
            [
                websockify_path,
                proxstar_port,
                '--token-plugin',
                'TokenFile',
                '--token-source',
                target_file,
                '-D',
            ],
            stdout=subprocess.PIPE,
        )
    else:
        print("Websockify started.")


def on_starting(server):
    print("Booting Websockify server in daemon mode...")
    start_websockify(app.config['WEBSOCKIFY_PATH'], app.config['WEBSOCKIFY_TARGET_FILE'])
