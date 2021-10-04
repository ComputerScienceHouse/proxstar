FROM postgres:12

RUN apt-get update \
    && apt-get install -y postgresql-plperl-12 \
    && apt-get install -y postgresql-plpython3-12 \
    && apt-get install -y libnet-ip-perl perl-net libnet-ldap-perl libnet-dns-perl libnet-snmp-perl libnet-server-mail-perl libcrypt-des-perl \
    && apt-get install -y libperl-dev build-essential \
    && rm -rf /var/lib/apt/lists/*
