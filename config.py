from os import environ

# Proxstar
VM_EXPIRE_MONTHS = int(environ.get('PROXSTAR_VM_EXPIRE_MONTHS', '3'))
VNC_CLEANUP_TOKEN = environ.get('PROXSTAR_VNC_CLEANUP_TOKEN', '')

# Development options
# Determines weather or not to run STARRS queries (for doing stuff like checking for available IPs)
USE_STARRS = environ.get('PROXSTAR_USE_STARRS', 'True').lower() in ('true', '1', 't')
# If you're an RTP and want to see a normal user's homepage view, set this to True.
FORCE_STANDARD_USER = environ.get('PROXSTAR_FORCE_STANDARD_USER', 'False').lower() in (
    'true',
    '1',
    't',
)


# Flask
IP = environ.get('PROXSTAR_IP', '0.0.0.0')
PORT = environ.get('PROXSTAR_PORT', '5000')
SERVER_NAME = environ.get('PROXSTAR_SERVER_NAME', 'proxstar.csh.rit.edu')
SECRET_KEY = environ.get('PROXSTAR_SECRET_KEY', '')

# OIDC
OIDC_ISSUER = environ.get('PROXSTAR_OIDC_ISSUER', 'https://sso.csh.rit.edu/auth/realms/csh')
OIDC_CLIENT_ID = environ.get('PROXSTAR_CLIENT_ID', 'proxstar')
OIDC_CLIENT_SECRET = environ.get('PROXSTAR_CLIENT_SECRET', '')

# Proxmox
PROXMOX_HOSTS = [host.strip() for host in environ.get('PROXSTAR_PROXMOX_HOSTS', '').split(',')]
PROXMOX_USER = environ.get('PROXSTAR_PROXMOX_USER', '')
PROXMOX_TOKEN_NAME = environ.get('PROXSTAR_PROXMOX_TOKEN_NAME', '')
PROXMOX_TOKEN_VALUE = environ.get('PROXSTAR_PROXMOX_TOKEN_VALUE', '')
PROXMOX_ISO_STORAGE = environ.get('PROXSTAR_PROXMOX_ISO_STORAGE', 'nfs-iso')
PROXMOX_VM_STORAGE = environ.get('PROXSTAR_PROXMOX_VM_STORAGE', 'ceph')
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
RQ_DASHBOARD_REDIS_URL = "redis://" + environ.get('PROXSTAR_REDIS_HOST', 'localhost') + ":" + environ.get('PROXSTAR_REDIS_PORT', '6379') + "/0"
REDIS_PORT = int(environ.get('PROXSTAR_REDIS_PORT', '6379'))

# VNC
WEBSOCKIFY_PATH = environ.get('PROXSTAR_WEBSOCKIFY_PATH', '/usr/local/bin/websockify')
WEBSOCKIFY_TARGET_FILE = environ.get('PROXSTAR_WEBSOCKIFY_TARGET_FILE', '/opt/proxstar/targets')
VNC_HOST = environ.get('PROXSTAR_VNC_HOST', 'proxstar-vnc.csh.rit.edu')
VNC_PORT = environ.get('PROXSTAR_VNC_PORT', '443')
WEBSOCKIFY_PORT = environ.get('PROXSTAR_WEBSOCKIFY_PORT', '8081')

# SENTRY
# If you set the sentry dsn locally, make sure you use the local-dev or some
# other local environment, so we can separate local errors from production
SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
RQ_SENTRY_DSN = environ.get('PROXSTAR_SENTRY_DSN', '')
SENTRY_ENV = environ.get('PROXSTAR_SENTRY_ENV', 'local-dev')

# DATADOG RUM
DD_CLIENT_TOKEN = environ.get('PROXSTAR_DD_CLIENT_TOKEN', '')
DD_APP_ID = environ.get('PROXSTAR_DD_APP_ID', '')

# GUNICORN
TIMEOUT = environ.get('PROXSTAR_TIMEOUT', 120)
