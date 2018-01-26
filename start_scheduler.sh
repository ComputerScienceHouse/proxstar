#!/bin/sh

/opt/app-root/bin/rq worker -u "$PROXSTAR_REDIS_URL"
