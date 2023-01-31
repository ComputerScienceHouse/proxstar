FROM python:3.9-buster
WORKDIR /opt/proxstar
RUN apt-get update -y && apt-get install -y python3-dev libldap2-dev libsasl2-dev ldap-utils git
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY start_worker.sh start_scheduler.sh .
COPY .git .git/
COPY *.py .
COPY proxstar ./proxstar
RUN touch targets && chmod a+w targets # This is some OKD shit.
RUN git config --global --add safe.directory /opt/proxstar # This is also some OKD shit.
ENTRYPOINT ddtrace-run gunicorn proxstar:app --bind=0.0.0.0:8080
