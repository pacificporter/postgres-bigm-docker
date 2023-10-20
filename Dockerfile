FROM postgres:12.11
LABEL maintainer="HARUYAMA Seigo <haruyama@pacificporter.jp>"

RUN apt-get update \
    && apt-get install -y curl make gcc postgresql-server-dev-12 libicu-dev \
    && cd /tmp \
    && curl -L -O https://ja.osdn.net/dl/pgbigm/pg_bigm-1.2-20200228.tar.gz \
    && tar zxf pg_bigm-1.2-20200228.tar.gz \
    && cd pg_bigm-1.2-20200228 \
    && make USE_PGXS=1 \
    && make USE_PGXS=1 install \
    && echo fsync=off >> /var/lib/postgresql/data/postgresql.conf \
    && echo synchronous_commit=off >> /var/lib/postgresql/data/postgresql.conf \
    && echo full_page_writes=off >> /var/lib/postgresql/data/postgresql.conf \
    && echo bgwriter_lru_maxpages=0 >> /var/lib/postgresql/data/postgresql.conf \
    && echo shared_preload_libraries='pg_bigm' >> /var/lib/postgresql/data/postgresql.conf \
    && rm -fr /tmp/pg_bigm-1.2-20200228 /tmp/pg_bigm-1.2-20200228.tar.gz \
    && apt-get purge -y curl make gcc postgresql-server-dev-12 libicu-dev \
    && rm -rf /var/lib/apt/lists/* 

STOPSIGNAL SIGINT
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
