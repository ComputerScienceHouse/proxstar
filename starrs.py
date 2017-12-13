import psycopg2
from flask import current_app as app


def connect_starrs():
    try:
        starrs = psycopg2.connect(
            "dbname='{}' user='{}' host='{}' password='{}'".format(
                app.config['STARRS_DB_NAME'], app.config['STARRS_DB_USER'],
                app.config['STARRS_DB_HOST'], app.config['STARRS_DB_PASS']))
    except:
        print("Unable to connect to STARRS database.")
        raise
    return starrs


def get_next_ip(starrs, range_name):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.get_address_from_range", (range_name, ))
        results = c.fetchall()
        c.execute("COMMIT")
    finally:
        c.close()
    return results


def get_ip_for_mac(starrs, mac):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.get_system_interface_addresses", (mac.lower(), ))
        results = c.fetchall()
        c.execute("COMMIT")
    finally:
        c.close()
    if not results:
        return 'No IP'
    return results[0][3]


def renew_ip(starrs, addr):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.renew_interface_address", (addr, ))
        results = c.fetchall()
        c.execute("COMMIT")
    finally:
        c.close()
    return results


def check_hostname(starrs, hostname):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.validate_name", (hostname, ))
        valid = False
        if hostname == c.fetchall()[0][0]:
            valid = True
        c.execute("COMMIT")
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.check_dns_hostname", (hostname, 'csh.rit.edu'))
        available = False
        if not c.fetchall()[0][0]:
            available = True
        c.execute("COMMIT")
    except (psycopg2.InternalError):
        valid = False
        available = False
    finally:
        c.close()
    return valid, available


def register_starrs(starrs, name, owner, mac, addr):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc(
            "api.create_system_quick",
            (name, owner, 'members', mac, addr, 'csh.rit.edu', 'dhcp', True))
        results = c.fetchall()
        c.execute("COMMIT")
    finally:
        c.close()
    return results


def delete_starrs(starrs, name):
    c = starrs.cursor()
    try:
        c.execute("BEGIN")
        c.callproc("api.initialize", ('root', ))
        c.callproc("api.remove_system", (name, ))
        results = c.fetchall()
        c.execute("COMMIT")
    finally:
        c.close()
    return results
