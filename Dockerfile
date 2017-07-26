FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
      locales \
      apt-transport-https \
      curl \
      wget \
      ca-certificates \
      python3-dev \
      python3-setuptools \
      postgresql-9.5 \
  && locale-gen en_US.UTF-8 \
  && dpkg-reconfigure locales \
  && easy_install3 pip==$_PIP_VERSION \
  && install -d /app -o nobody -g nogroup -m 0755

COPY [".", "/app/"]

RUN pip3 install -r /app/requirements.txt

RUN service postgresql start \
  && su - postgres -c "createuser --superuser dbuser" \
  && su - postgres -c "psql -c\"alter user dbuser with password 'secret123'\"" \
  && service postgresql stop
