Proxstar
===========

Proxstar is a proxmox VM web management tool used by [Rochester Institute of Technology](https://rit.edu/)'s [Computer Science House](https://csh.rit.edu).

## Overview

Written using [Python](http://nodejs.org), [Flask](https://npmjs.com).

Proxstar removes the need for CSH members to have direct access to the proxmox web interface.

Proxstar is also used to enforce proxmox resource limits automagically.

It is available to house members at [proxstar.csh.rit.edu](https://proxstar.csh.rit.edu) behind PYOIDC authentication.

## Contributing

1. [Fork](https://help.github.com/en/articles/fork-a-repo) this repository
  - Optionally create a new [git branch](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell) if your change is more than a small tweak (`git checkout -b BRANCH-NAME-HERE`)
3. Make your changes locally, commit, and push to your fork
  - If you want to test locally, you should copy `config.py` to `config_local.py`, and talk to an RTP about filling in secrets.
  - Lint and format your local changes with `pylint proxstar` and `black proxstar`
    - You'll need dependencies installed locally to do this. You should do that in a [venv](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) of some sort to keep your system clean. All the dependencies are listed in [requirements.txt](./requirements.txt), so you can install everything with `pip install -r requirements.txt`. You'll need python 3.6 at minimum, though things should work up to python 3.8.
4. Create a [Pull Request](https://help.github.com/en/articles/about-pull-requests) on this repo for our Webmasters to review

## Questions/Concerns

Please file an [Issue](https://github.com/ComputerScienceHouse/proxstar/issues/new) on this repository.
