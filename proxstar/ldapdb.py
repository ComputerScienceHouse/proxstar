from csh_ldap import CSHLDAP
from flask import current_app as app

from proxstar import logging

_ldap = None


def connect_ldap():
    global _ldap
    try:
        # This is fine because CSHLDAP functions are decorated with @reconnect_on_fail
        if _ldap is None:
            _ldap = CSHLDAP(app.config['LDAP_BIND_DN'], app.config['LDAP_BIND_PW'])
    except Exception as e:
        logging.error('unable to connect to LDAP: %s', e)
        raise
    return _ldap


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
        ldap.get_member(user, uid=True)
        return True
    except:
        return False
