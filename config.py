from os import environ

# Proxstar
VM_EXPIRE_MONTHS = int(environ.get('PROXSTAR_VM_EXPIRE_MONTHS', '3'))
VNC_CLEANUP_TOKEN = environ.get('PROXSTAR_VNC_CLEANUP_TOKEN', '')

# Flask
IP = environ.get('PROXSTAR_IP', '0.0.0.0')
PORT = environ.get('PROXSTAR_PORT', '5000')
SERVER_NAME = environ.get('PROXSTAR_SERVER_NAME', 'proxstar.csh.rit.edu')
SECRET_KEY = environ.get('PROXSTAR_SECRET_KEY', '')

# OIDC
OIDC_ISSUER = environ.get('PROXSTAR_OIDC_ISSUER',
                          'https://sso.csh.rit.edu/auth/realms/csh')
OIDC_CLIENT_CONFIG = {
    'client_id':
    environ.get('PROXSTAR_CLIENT_ID', 'proxstar'),
    'client_secret':
    environ.get('PROXSTAR_CLIENT_SECRET', ''),
    'post_logout_redirect_uris': [
        environ.get('PROXSTAR_REDIRECT_URI',
                    'https://proxstar.csh.rit.edu/logout')
    ]
}

# Proxmox
PROXMOX_HOSTS = [
    host.strip()
    for host in environ.get('PROXSTAR_PROXMOX_HOSTS', '').split(',')
]
PROXMOX_USER = environ.get('PROXSTAR_PROXMOX_USER', '')
PROXMOX_PASS = environ.get('PROXSTAR_PROXMOX_PASS', '')
PROXMOX_ISO_STORAGE = environ.get('PROXSTAR_PROXMOX_ISO_STORAGE', 'nfs-iso')
PROXMOX_SSH_USER = environ.get('PROXSTAR_PROXMOX_SSH_USER', '')
PROXMOX_SSH_KEY = environ.get('PROXSTAR_PROXMOX_SSH_KEY', '')
PROXMOX_SSH_KEY_PASS = environ.get('PROXSTAR_PROXMOX_SSH_KEY_PASS', '')

# STARRS
STARRS_DB_HOST = environ.get('PROXSTAR_STARRS_DB_HOST', '')
STARRS_DB_NAME = environ.get('PROXSTAR_DB_NAME', 'starrs')
STARRS_DB_USER = environ.get('PROXSTAR_DB_USER', '')
STARRS_DB_PASS = environ.get('PROXSTAR_DB_PASS', '')
STARRS_USER = environ.get('PROXSTAR_STARRS_USER', 'proxstar')
STARRS_IP_RANGE = environ.get('PROXSTAR_IP_RANGE', '')

# LDAP
LDAP_BIND_DN = environ.get('PROXSTAR_LDAP_BIND_DN', '')
LDAP_BIND_PW = environ.get('PROXSTAR_LDAP_BIND_PW', '')

# DB
SQLALCHEMY_DATABASE_URI = environ.get('PROXSTAR_SQLALCHEMY_DATABASE_URI', '')

# REDIS
REDIS_HOST = environ.get('PROXSTAR_REDIS_HOST', 'localhost')
RQ_DASHBOARD_REDIS_HOST = environ.get('PROXSTAR_REDIS_HOST', 'localhost')
REDIS_PORT = int(environ.get('PROXSTAR_REDIS_PORT', '6379'))

# VNC
WEBSOCKIFY_PATH = environ.get('PROXSTAR_WEBSOCKIFY_PATH',
                              '/opt/app-root/bin/websockify')
WEBSOCKIFY_TARGET_FILE = environ.get('PROXSTAR_WEBSOCKIFY_TARGET_FILE',
                                     '/opt/app-root/src/targets')

# SENTRY
# If you set the sentry dsn locally, make sure you use the local-dev or some
# other local environment, so we can separate local errors from production
SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
RQ_SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
SENTRY_ENV = environ.get('PROXSTAR_SENTRY_ENV', 'local-dev')
