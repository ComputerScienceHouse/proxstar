from flask_pyoidc.flask_pyoidc import OIDCAuthentication
from tenacity import retry


@retry
def get_auth(app):
    auth = OIDCAuthentication(
        app,
        issuer=app.config['OIDC_ISSUER'],
        client_registration_info=app.config['OIDC_CLIENT_CONFIG'])
    return auth
