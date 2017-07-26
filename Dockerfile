FROM ubuntu:xenial
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install python3-setuptools \
  && easy_install3 pip==9.0.1
