FROM postgres:12

RUN apt-get update \
    && apt-get install -y postgresql-plperl-12 postgresql-plpython3-12 libnet-ip-perl libnet-ldap-perl libnet-dns-perl libnet-snmp-perl libnet-server-mail-perl libcrypt-des-perl build-essential cpanminus curl \
    && rm -rf /var/lib/apt/lists/* \
    && cpanm Data::Validate::Domain \
    && apt-get remove -y build-essential

COPY ./schema/large.sql /docker-entrypoint-initdb.d/
