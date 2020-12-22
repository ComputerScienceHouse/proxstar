from flask_pyoidc.flask_pyoidc import OIDCAuthentication
from flask_pyoidc.provider_configuration import ProviderConfiguration, ClientMetadata
from tenacity import retry


@retry
def get_auth(app):
    sso_config = ProviderConfiguration(
        issuer=app.config['OIDC_ISSUER'],
        client_metadata=ClientMetadata(
            app.config['OIDC_CLIENT_CONFIG']['client_id'],
            app.config['OIDC_CLIENT_CONFIG']['client_secret'],
        ),
    )

    auth = OIDCAuthentication({'sso': sso_config}, app)
    return auth
