import random


def gen_password(
        length,
        charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"
):
    # use secrets module once this works in python 3.6
    return ''.join(random.choice(charset) for x in range(length))


def lazy_property(fn):
    # Decorator that makes a property lazy-evaluated (https://stevenloria.com/lazy-properties/)
    attr_name = '_lazy_' + fn.__name__

    @property
    def _lazy_property(self):
        if not hasattr(self, attr_name):
            setattr(self, attr_name, fn(self))
        return getattr(self, attr_name)

    return _lazy_property
