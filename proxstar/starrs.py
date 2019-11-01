import psycopg2


def get_next_ip(starrs, range_name):
    c = starrs.cursor()
    try:
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.get_address_from_range', (range_name, ))
        results = c.fetchall()
        c.execute('COMMIT')
    finally:
        c.close()
    return results[0][0]


def get_ip_for_mac(starrs, mac):
    c = starrs.cursor()
    try:
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.get_system_interface_addresses', (mac.lower(), ))
        results = c.fetchall()
        c.execute('COMMIT')
    finally:
        c.close()
    if not results:
        return 'No IP'
    return results[0][3]


def renew_ip(starrs, addr):
    c = starrs.cursor()
    try:
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.renew_interface_address', (addr, ))
        results = c.fetchall()
        c.execute('COMMIT')
    finally:
        c.close()
    return results


# Use various STARRS stored procedures to make sure the hostname is valid/available
def check_hostname(starrs, hostname):
    c = starrs.cursor()
    try:
        # Check for invalid characters in hostname
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.validate_name', (hostname, ))
        c.execute('COMMIT')
        # Validate the entire domain name using Data::Validate::Domain
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.validate_domain', (hostname, 'csh.rit.edu'))
        valid = c.fetchall()[0][0]
        c.execute('COMMIT')
        # Check if the hostname is available (checks A/SRV/CNAME records)
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.check_dns_hostname', (hostname, 'csh.rit.edu'))
        available = False
        if not c.fetchall()[0][0]:
            available = True
        c.execute('COMMIT')
        # Check if the system name is taken
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.get_system', (hostname, ))
        if c.fetchall():
            available = False
        c.execute('COMMIT')
    except psycopg2.InternalError:
        valid = False
        available = False
    finally:
        c.close()
    return valid, available


def register_starrs(starrs, name, owner, mac, addr):
    c = starrs.cursor()
    try:
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc(
            'api.create_system_quick',
            (name, owner, 'members', mac, addr, 'csh.rit.edu', 'dhcp', True))
        results = c.fetchall()
        c.execute('COMMIT')
    finally:
        c.close()
    return results


def delete_starrs(starrs, name):
    c = starrs.cursor()
    try:
        c.execute('BEGIN')
        c.callproc('api.initialize', ('root', ))
        c.callproc('api.remove_system', (name, ))
        results = c.fetchall()
        c.execute('COMMIT')
    finally:
        c.close()
    return results
