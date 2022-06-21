## Setting up a full dev environment

If you want to work on Proxstar using a 1:1 development setup, there are a couple things you're going to need

- A machine you can
    - SSH into
        - With portforwarding (see `man ssh` for info on the `-L` option)
    - and run
        - Flask
        - Redis
        - Docker
- At least one (1) Proxmox host running Proxmox >6.3
- A CSH account
- An RTP (to tell you secrets)

1. Configure your Proxmox node (Not required if you're using the CSH cluster)

I would recommend setting up a development account on your Proxmox node. Name it anything. (Maybe `proxstartest`?). This is necessary to grab authentication tokens and the like. It should have the same permissions as `root@pam`. You can accomplish this by creating a group in `Datacenter > Permissions > Groups` and adding `Administrator` permissions to the group, then adding your user to the group. If you do this, then it's easy to enable/disable it for development. You should also generate an SSH key for the user.

When you log into your Proxstar instance, it should auto-create the pool. If for some reason it doesn't, you can set up a pool on your Proxmox node with your CSH username. To do this, go into `Datacenter > Permissions > Pools > Create`.

2. Set up your environment

If you're trying to run this all on a VM without a graphical web browser, you can forward traffic to your computer using SSH.
```
ssh example@dev-server.csh.rit.edu -L 8000:localhost:8000
```
# New Deployment Instructions

1.  Build your containers. The `proxstar` container serves as proxstar, rq, rq-scheduler, and VNC. The `proxstar-postgres` container sets up the database schema.

`podman build . --tag=proxstar`

`podman build HACKING/proxstar-postgres --tag=proxstar-postgres`

2. Configure your environment variables. I'd recommend setting up a .env file and passing that into your container. Check `.env.template` for more info.

3. Run it with this clusterfuck. This sets up redis, postgres, rq, and proxstar.

```
podman run --rm -d --network=proxstar --name=proxstar-redis redis:alpine
podman run --rm -d --network=proxstar --name=proxstar-postgres -e POSTGRES_PASSWORD=changeme -v ./HACKING/proxstar-postgres//volume:/var/lib/postgresql/data:Z proxstar-postgres
podman run --rm -d --network=proxstar --name=proxstar-rq-scheduler  --env-file=HACKING/.env --entrypoint ./start_scheduler.sh proxstar
podman run --rm -d --network=proxstar --name=proxstar-rq  --env-file=HACKING/.env --entrypoint ./start_worker.sh proxstar
podman run --rm -d --network=proxstar --name=proxstar -p 8000:8000 --env-file=HACKING/.env proxstar
```
