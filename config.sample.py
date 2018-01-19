# Proxstar
VM_EXPIRE_MONTHS = 3
IGNORED_POOLS = []

# Flask
IP = '127.0.0.1'
PORT = '5000'
SERVER_NAME = 'proxstar.csh.rit.edu'
SECRET_KEY = ''

# OIDC
OIDC_ISSUER = 'https://sso.csh.rit.edu/realms/csh'
OIDC_CLIENT_CONFIG = {
    'client_id': 'proxstar',
    'client_secret': '',
    'post_logout_redirect_uris': ['https://proxstar.csh.rit.edu/logout']
}

# Proxmox
PROXMOX_HOST = ''
PROXMOX_USER = ''
PROXMOX_PASS = ''
PROXMOX_ISO_STORAGE = 'nfs-iso'

# STARRS
STARRS_DB_HOST = ''
STARRS_DB_NAME = ''
STARRS_DB_USER = ''
STARRS_DB_PASS = ''
STARRS_USER = 'proxstar'
STARRS_IP_RANGE = ''

# LDAP
LDAP_BIND_DN = ''
LDAP_BIND_PW = ''
