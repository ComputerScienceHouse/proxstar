import psycopg2


def connect_starrs(db, user, host, password):
    try:
        starrs = psycopg2.connect(
            "dbname='{}' user='{}' host='{}' password='{}'".format(
                db, user, host, password))
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
