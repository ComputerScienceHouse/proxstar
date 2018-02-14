import string
import random
from proxstar.db import *


def gen_password(
        length,
        charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"
):
    # use secrets module once this works in python 3.6
    return ''.join(random.choice(charset) for x in range(length))


def build_user_dict(session, db):
    user_dict = dict()
    user_dict['username'] = session['userinfo']['preferred_username']
    user_dict[
        'active'] = 'active' in session['userinfo']['groups'] or 'current_student' in session['userinfo']['groups'] or user_dict['username'] in get_allowed_users(
            db)
    user_dict['rtp'] = 'rtp' in session['userinfo']['groups']
    return user_dict
