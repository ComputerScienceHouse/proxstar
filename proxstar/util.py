import secrets


def gen_password(
        length,
        charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*"
):
    return "".join([secrets.choice(charset) for _ in range(0, length)])
