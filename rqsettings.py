import os

import sentry_sdk
from sentry_sdk.integrations.rq import RqIntegration
from sentry_sdk.integrations.redis import RedisIntegration

if os.path.exists('config_local.py'):
    try:
        import config_local as config  # pylint: disable=import-error
    except ImportError:
        import config
else:
    import config

sentry_sdk.init(
    config.SENTRY_DSN,
    integrations=[RqIntegration(), RedisIntegration()],
    environment=config.SENTRY_ENV,
)
