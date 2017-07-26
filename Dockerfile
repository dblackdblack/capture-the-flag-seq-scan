FROM ubuntu:xenial

ENV _PIP_VERSION=9.0.1

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install apt-transport-https curl wget ca-certificates python3-setuptools \
  && easy_install3 pip==$_PIP_VERSION
