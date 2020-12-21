from functools import lru_cache
from csh_ldap import CSHLDAP
from flask import current_app as app

from proxstar import logging, ldap_conn


def connect_ldap():
    try:
        ldap = CSHLDAP(app.config['LDAP_BIND_DN'], app.config['LDAP_BIND_PW'])
    except Exception as e:
        logging.error('unable to connect to LDAP: %s', e)
        raise
    return ldap


@lru_cache(maxsize=128)
def is_rtp(user):
    rtp_group = ldap_conn.get_group('rtp')
    return rtp_group.check_member(ldap_conn.get_member(user, uid=True))


@lru_cache(maxsize=128)
def is_active(user):
    active_group = ldap_conn.get_group('active')
    return active_group.check_member(ldap_conn.get_member(user, uid=True))


@lru_cache(maxsize=128)
def is_current_student(user):
    current_student_group = ldap_conn.get_group('current_student')
    return current_student_group.check_member(ldap_conn.get_member(user, uid=True))


@lru_cache(maxsize=128)
def is_user(user):
    try:
        ldap_conn.get_member(user, uid=True)
        return True
    except:
        return False
