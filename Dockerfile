FROM python:3.8-buster
WORKDIR /opt/proxstar
RUN apt-get update -y && apt-get install -y python3-dev libldap2-dev libsasl2-dev ldap-utils
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY start_worker.sh start_scheduler.sh .
COPY .git ./.git
COPY *.py .
COPY proxstar ./proxstar
RUN touch proxmox_ssh_key targets && chmod a+w proxmox_ssh_key targets # This is some OKD shit.
# This is so cringe, but it's for development. Comment this before pushing.
#COPY HACKING/ssh_key proxmox_ssh_key
ENTRYPOINT ddtrace-run python3 wsgi.py
