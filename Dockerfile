FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LANG=en_US.UTF-8

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
  && easy_install3 pip==$_PIP_VERSION \
  && pip3 install gunicorn virtualenv \
  && dpkg-reconfigure locales
  
RUN service postgresql start \
  && su - postgres -c "createuser --superuser dbuser" \
  && service postgresql stop
