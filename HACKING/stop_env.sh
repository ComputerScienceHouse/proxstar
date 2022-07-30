#!/bin/bash
podman kill proxstar
podman kill proxstar-rq
podman kill proxstar-rq-scheduler
podman stop proxstar-redis
podman stop proxstar-postgres
