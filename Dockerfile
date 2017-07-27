FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    POSTGRES_VERSION=9.5 

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install locales \
  && locale-gen en_US.UTF-8 \
  && dpkg-reconfigure locales \
  && apt-get -y install \
      apt-transport-https \
      curl \
      wget \
      ca-certificates \
      python3-dev \
      python3-setuptools \
      postgresql-${POSTGRES_VERSION} \
      libpq-dev \
      build-essential \
  && easy_install3 pip==$_PIP_VERSION \
  && install -d /app -o nobody -g nogroup -m 0755

COPY ["requirements.txt", "/app/"]

RUN pip3 install -r /app/requirements.txt

RUN su - postgres -c "pg_dropcluster --stop ${POSTGRES_VERSION} main" \
  && pg_createcluster --locale en_US.UTF-8 --start ${POSTGRES_VERSION} main \
  && su - postgres -c "createuser --superuser dbuser" \
  && su - postgres -c "psql -c\"alter user dbuser with password 'secret123'\"" \
  && su - postgres -c "createdb --owner dbuser --locale en_US.UTF-8 db" \
  && service postgresql stop

COPY ["app", "/app/"]
ENV DATABASE_URL=postgresql://dbuser:secret123@localhost:5432/db
