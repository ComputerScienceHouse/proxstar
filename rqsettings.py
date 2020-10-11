import os

import sentry_sdk
from sentry_sdk.integrations.rq import RqIntegration

sentry_sdk.init(
    os.environ.get('PROXSTAR_SENTRY_DSN'),
    integrations=[RqIntegration()]
)
