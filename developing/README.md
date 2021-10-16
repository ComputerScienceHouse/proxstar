## Setting up a full dev environment

If you want to work on Proxstar using a 1:1 development setup, there are a couple things you're going to need

- A machine you can
    - SSH into
        - With portforwarding (see `man ssh` for info on the `-L` option)
    - and run
        - Flask
        - Redis
        - Docker
- At least one (1) Proxmox host running Proxmox >6.3
- A CSH account
- An RTP (to tell you secrets)

1. Configure your Proxmox node

I would recommend setting up a development account on your Proxmox node. Name it anything. (Maybe `proxstartest`?). This is necessary to grab authentication tokens and the like. It should have the same permissions as `root@pam`. You can accomplish this by creating a group in `Datacenter > Permissions > Groups` and adding `Administrator` permissions to the group, then adding your user to the group. If you do this, then it's easy to enable/disable it for development. You should also generate an SSH key for the user.

When you log into your Proxstar instance, it should auto-create the pool. If for some reason it doesn't, you can set up a pool on your Proxmox node with your CSH username. To do this, go into `Datacenter > Permissions > Pools > Create`.

2. Set up your environment

If you're trying to run this all on a VM without a graphical web browser, you can forward traffic to your computer using SSH.
```
ssh example@dev-server.csh.rit.edu -L 8000:localhost:8000
```

Clone down the repository, and create a Virtualenv to do your work in.
```
mkdir venv
python3.8 -m venv venv
source venv/bin/activate
```

Install required Python modules
```
pip install -r requirements.txt
pip install click==7.1.2 python-dotenv
```
Fill out the required fields in your config_local.py file. You might have to come back to this after you run the docker compose.
```
cp config.py config_local.py
vim config_local.py
```

(Here's some advice on how to fill out your config file.)
```
  from os import environ

  # Proxstar
  VM_EXPIRE_MONTHS = int(environ.get('PROXSTAR_VM_EXPIRE_MONTHS', '3'))
  VNC_CLEANUP_TOKEN = environ.get('PROXSTAR_VNC_CLEANUP_TOKEN', '')

  # Flask

  # The IP address to which Proxstar is served.
  # You should probably set this to 127.0.0.1 if you're developing on your
  # local machine, or portforwarding through SSH.
  # 0.0.0.0 will serve to wherever you want. Don't do that unless you know
  # what you're doing.
  IP = environ.get('PROXSTAR_IP', '127.0.0.1') 

  # The port Proxstar runs on.
  # Because sso is configured to accept from `http://localhost:8000', you should
  # set this to 8000 for development.
  PORT = environ.get('PROXSTAR_PORT', '5000')

  # The name of your proxstar server. This matters for authenticating with CSH
  # SSO, so change this to localhost:8000
  SERVER_NAME = environ.get('PROXSTAR_SERVER_NAME', 'proxstar.csh.rit.edu')

  # Secret key for authenticating with SSO.
  # Change this to literally anything, just don't leave it blank.
  SECRET_KEY = environ.get('PROXSTAR_SECRET_KEY', '')

  # OIDC

  # Leave all of this alone.
  OIDC_ISSUER = environ.get('PROXSTAR_OIDC_ISSUER', 'https://sso.csh.rit.edu/auth/realms/csh')
  OIDC_CLIENT_CONFIG = {
      'client_id': environ.get('PROXSTAR_CLIENT_ID', 'proxstar'),
      'client_secret': environ.get('PROXSTAR_CLIENT_SECRET', ''), # Just kidding, talk to an RTP to get this.
      'post_logout_redirect_uris': [
          environ.get('PROXSTAR_REDIRECT_URI', 'https://proxstar.csh.rit.edu/logout')
      ],
  }

  # Proxmox

  # Your list of proxmox hosts. You only need one for development.
  PROXMOX_HOSTS = [host.strip() for host in environ.get('PROXSTAR_PROXMOX_HOSTS', '').split(',')]
  # Username and group of your test user. For example, 'proxstartest@pam'
  PROXMOX_USER = environ.get('PROXSTAR_PROXMOX_USER', '')
  # Said user's password
  PROXMOX_PASS = environ.get('PROXSTAR_PROXMOX_PASS', '')
  # Location of ISO storage on your server. CSH has an NFS share for this,
  # but usually this is 'local'
  PROXMOX_ISO_STORAGE = environ.get('PROXSTAR_PROXMOX_ISO_STORAGE', 'local')
  # Location of storage for VMs. CSH has a ceph cluster, but change this to
  # whatever the name of your cluster's storage is. By default Proxmox uses
  # local-lvm
  PROXMOX_VM_STORAGE = environ.get('PROXSTAR_PROXMOX_VM_STORAGE', 'ceph')
  # Username of SSH user (probably the same)
  PROXMOX_SSH_USER = environ.get('PROXSTAR_PROXMOX_SSH_USER', '')
  # Paste that SSH key I told you to generate.
  PROXMOX_SSH_KEY = environ.get('PROXSTAR_PROXMOX_SSH_KEY', '')
  # If you put a password on it, then paste that here.
  PROXMOX_SSH_KEY_PASS = environ.get('PROXSTAR_PROXMOX_SSH_KEY_PASS', '')

  # STARRS

  # The IP address or hostname of your STARRs host.

  # Since you should be hosting this in a container, make it 127.0.0.1
  STARRS_DB_HOST = environ.get('PROXSTAR_STARRS_DB_HOST', '')

  # The name of your STARRS DB
  # It.... it should be STARRS.
  STARRS_DB_NAME = environ.get('PROXSTAR_DB_NAME', 'starrs')

  # The username of your STARRS DB
  # I just used the postgres user and it seemed to work so uhhhhhhhhhhh
  STARRS_DB_USER = environ.get('PROXSTAR_DB_USER', '')

  # Password for Postgres user
  # (You configure this when setting up the Postgres container just use that PWord)
  STARRS_DB_PASS = environ.get('PROXSTAR_DB_PASS', '')

  # STARRS username
  # Leave this alone.
  STARRS_USER = environ.get('PROXSTAR_STARRS_USER', 'proxstar')

  #???
  # IDK leave this alone, too.
  STARRS_IP_RANGE = environ.get('PROXSTAR_IP_RANGE', '')

  # LDAP

  # You can just use your LDAP Bind DN and Password here
  # (remember to keep them hidden!)
  LDAP_BIND_DN = environ.get('PROXSTAR_LDAP_BIND_DN', '')
  LDAP_BIND_PW = environ.get('PROXSTAR_LDAP_BIND_PW', '')

  # DB

  # The URI to your proxstar DB.
  # Probably looks like this: postgresql://postgres:********@localhost/proxstar
  SQLALCHEMY_DATABASE_URI = environ.get('PROXSTAR_SQLALCHEMY_DATABASE_URI', '')

  # REDIS
  # Leave this alone. This will point at your Redis container.
  REDIS_HOST = environ.get('PROXSTAR_REDIS_HOST', 'localhost')
  RQ_DASHBOARD_REDIS_HOST = environ.get('PROXSTAR_REDIS_HOST', 'localhost')
  REDIS_PORT = int(environ.get('PROXSTAR_REDIS_PORT', '6379'))

  # VNC

  #Haha this is so fucking busted. Leave this alone.
  WEBSOCKIFY_PATH = environ.get('PROXSTAR_WEBSOCKIFY_PATH', '/opt/app-root/bin/websockify')
  WEBSOCKIFY_TARGET_FILE = environ.get('PROXSTAR_WEBSOCKIFY_TARGET_FILE', '/opt/app-root/src/targets')

  # SENTRY
  # If you set the sentry dsn locally, make sure you use the local-dev or some
  # other local environment, so we can separate local errors from production

  # Leave this alone, too.
  SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
  RQ_SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
  SENTRY_ENV = environ.get('PROXSTAR_SENTRY_ENV', 'local-dev')

  # DATADOG RUM

  # Leave this alone, too
  DD_CLIENT_TOKEN = environ.get('PROXSTAR_DD_CLIENT_TOKEN', '')
  DD_APP_ID = environ.get('PROXSTAR_DD_APP_ID', '')

  # GUNICORN

  # Yeah whatever, leave it alone.
  TIMEOUT = environ.get('PROXSTAR_TIMEOUT', 120)
```

Now, go ahead and run the Docker Compose file to set up your Postgres and Redis instances.

```
docker-compose up -d
```

Now, you should be ready to run your dev instance. I like to use `tmux` for this to run proxstar and the `rq worker` in separate panes.

```
  flask run -p 8000 --cert=adhoc
  rq worker
```

(You might have to specify your host as `-h 127.0.0.1` if Flask is misbehaving)

Open a web browser and navigate to http://localhost:8000. You should see Proxstar running.
