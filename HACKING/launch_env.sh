#!/bin/bash
podman run --rm -d --network=proxstar --name=proxstar-redis redis:alpine
podman run --rm -d --network=proxstar --name=proxstar-postgres -e POSTGRES_PASSWORD=changeme -v ./HACKING/proxstar-postgres/volume:/var/lib/postgresql/data:Z proxstar-postgres
podman run --rm -d --network=proxstar --name=proxstar-rq-scheduler  --env-file=HACKING/.env --entrypoint ./start_scheduler.sh proxstar
podman run --rm -d --network=proxstar --name=proxstar-rq  --env-file=HACKING/.env --entrypoint ./start_worker.sh proxstar
podman run --rm -it --network=proxstar --name=proxstar -p 8000:8000 -p 8001:8001 --env-file=HACKING/.env --entrypoint='["gunicorn", "proxstar:app", "--bind=0.0.0.0:8000"]' proxstar
