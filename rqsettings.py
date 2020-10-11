import os

import sentry_sdk
from sentry_sdk.integrations.rq import RqIntegration

if os.path.exists('config_local.py'):
    import config_local as config
else:
    import config

sentry_sdk.init(
    config.SENTRY_DSN,
    integrations=[RqIntegration()]
)
