from flask_pyoidc import OIDCAuthentication
from flask_pyoidc.provider_configuration import ClientMetadata, ProviderConfiguration
from tenacity import retry


@retry
def get_auth(app):
    auth = OIDCAuthentication(
        provider_configurations={
            'default': ProviderConfiguration(
                issuer=app.config['OIDC_ISSUER'],
                client_metadata=ClientMetadata(
                    client_id=app.config['OIDC_CLIENT_ID'],
                    client_secret=app.config['OIDC_CLIENT_SECRET'],
                ),
            ),
        },
        app=app,
    )
    return auth
