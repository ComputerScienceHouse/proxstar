import string
import random


def gen_password(length, charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"):
    # use secrets module once this works in python 3.6
    return ''.join(random.choice(charset) for x in range(length))
