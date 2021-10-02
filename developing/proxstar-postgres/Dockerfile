FROM postgres:12

RUN apt-get update \
    && apt-get install -y postgresql-plperl-12 \
    && apt-get install -y postgresql-plpython3-12 \
    && rm -rf /var/lib/apt/lists/*
