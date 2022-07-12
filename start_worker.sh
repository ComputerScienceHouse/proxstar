#!/bin/sh

PROXSTAR_REDIS_URL=redis://$PROXSTAR_REDIS_HOST:$PROXSTAR_REDIS_PORT

rq worker -u "$PROXSTAR_REDIS_URL" --sentry-dsn "" -c rqsettings
