#!/bin/bash
podman run --rm -d --network=proxstar --name=proxstar-redis redis:alpine
podman run --rm -d --network=proxstar --name=proxstar-postgres -e POSTGRES_PASSWORD=changeme -v ./HACKING/proxstar-postgres/volume:/var/lib/postgresql/data:Z proxstar-postgres
podman run --rm -d --network=proxstar --name=proxstar-rq-scheduler  --env-file=HACKING/.env --entrypoint ./start_scheduler.sh proxstar
podman run --rm -d --network=proxstar --name=proxstar-rq  --env-file=HACKING/.env --entrypoint ./start_worker.sh proxstar
podman run --rm -d --network=proxstar --name=proxstar -p 8000:8000 --env-file=HACKING/.env --entrypoint='["python3", "wsgi.py"]' proxstar
