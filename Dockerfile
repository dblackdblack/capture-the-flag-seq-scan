FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
      apt-transport-https \
      curl \
      wget \
      ca-certificates \
      python3-dev \
      python3-setuptools \
      postgresql-9.5 \
  && easy_install3 pip==$_PIP_VERSION \
  && pip3 install gunicorn virtualenv
  
RUN service postgresql start \
  && su - postgres -c "createuser --superuser dbuser" \
  && service postgresql stop
