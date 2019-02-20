from csh_ldap import CSHLDAP
from flask import current_app as app

from proxstar import logging


def connect_ldap():
    try:
        ldap = CSHLDAP(app.config['LDAP_BIND_DN'], app.config['LDAP_BIND_PW'])
    except Exception as e:
        logging.error("unable to connect to LDAP: %s", e)
        raise
    return ldap


def is_rtp(user):
    ldap = connect_ldap()
    rtp_group = ldap.get_group('rtp')
    return rtp_group.check_member(ldap.get_member(user, uid=True))


def is_active(user):
    ldap = connect_ldap()
    active_group = ldap.get_group('active')
    return active_group.check_member(ldap.get_member(user, uid=True))


def is_current_student(user):
    ldap = connect_ldap()
    current_student_group = ldap.get_group('current_student')
    return current_student_group.check_member(ldap.get_member(user, uid=True))


def is_user(user):
    ldap = connect_ldap()
    try:
        rtp_group = ldap.get_member(user, uid=True)
        return True
    except:
        return False
