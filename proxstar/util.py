import random


def gen_password(
    length, charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*'
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


def default_repr(cls):
    """
    Add a default repr to a class in the form of
    ```
    Class(field1=val1, field2=val2...)
    ```
    """

    def __repr__(self):
        fields = [f'{key}={val}' for key, val in self.__dict__.items()]
        return f'{type(self).__name__}({', '.join(fields)})'

    setattr(cls, '__repr__', __repr__)

    return cls
