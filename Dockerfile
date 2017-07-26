FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install python3-setuptools \
  && easy_install3 pip==$_PIP_VERSION
