import os
import subprocess

from flask import Flask

app = Flask(__name__)
if os.path.exists(
        os.path.join(
            app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")):
    config = os.path.join(
        app.config.get('ROOT_DIR', os.getcwd()), "config.local.py")
else:
    config = os.path.join(app.config.get('ROOT_DIR', os.getcwd()), "config.py")
app.config.from_pyfile(config)


def start_websockify(websockify_path, target_file):
    result = subprocess.run(['pgrep', 'websockify'], stdout=subprocess.PIPE)
    if not result.stdout:
        subprocess.call([
            websockify_path, '8081', '--token-plugin', 'TokenFile',
            '--token-source', target_file, '-D'
        ],
                        stdout=subprocess.PIPE)


def on_starting(server):
    start_websockify(app.config['WEBSOCKIFY_PATH'],
                     app.config['WEBSOCKIFY_TARGET_FILE'])
