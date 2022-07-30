# Contributing
1. [Fork](https://help.github.com/en/articles/fork-a-repo) this repository
  - Optionally create a new [git branch](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell) if your change is more than a small tweak (`git checkout -b BRANCH-NAME-HERE`)

2. Follow the _Podman Environment Instructions_ to set up a Podman dev environment. If you'd like to run Proxstar entirely on your own hardware, check out _Setting up a full dev environment_

3. Create a Virtualenv to do your linting in
```
mkdir venv
python3.8 -m venv venv
source venv/bin/activate
```

4. Make your changes locally, commit, and push to your fork
  - If you want to test locally, you should copy `HACKING/.env.sample` to `HACKING/.env`, and talk to an RTP about filling in secrets.
  - Lint and format your local changes with `pylint proxstar` and `black proxstar`
    - You'll need dependencies installed locally to do this. You should do that in a [venv](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) of some sort to keep your system clean. All the dependencies are listed in [requirements.txt](./requirements.txt), so you can install everything with `pip install -r requirements.txt`. You'll need python 3.6 at minimum, though things should work up to python 3.8.

5. Create a [Pull Request](https://help.github.com/en/articles/about-pull-requests) on this repo for our Webmasters to review

### Podman Environment Instructions

1.  Build your containers. The `proxstar` container serves as proxstar, rq, rq-scheduler, and VNC. The `proxstar-postgres` container sets up the database schema.

`mkdir HACKING/proxstar-postgres/volume`

`podman build . --tag=proxstar`

`podman build HACKING/proxstar-postgres --tag=proxstar-postgres`

2. Configure your environment variables. I'd recommend setting up a .env file and passing that into your container. Check `.env.template` for more info.

3. Run it. This sets up redis, postgres, rq, and proxstar.

`./HACKING/launch_env.sh`

4. To stop all containers, use the provided script

`./HACKING/stop_env.sh`

## Setting up a full dev environment

If you want to work on Proxstar using a 1:1 development setup, there are a couple things you're going to need

- A machine you can
    - SSH into
        - With portforwarding (see `man ssh` for info on the `-L` option)
    - and run
        - Podman
        - Flask
		- Redis
		- Postgres
		- RQ
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

