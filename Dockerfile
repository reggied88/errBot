FROM ubuntu:16.04

MAINTAINER Reggie Davis <reggied@blinds.com> 

RUN groupadd -r errbot && useradd -g errbot -d /srv/errbot-root errbot

RUN apt-get -y update
RUN apt-get -y install python python3-pip git locales

# Set default locale for the environment
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US.UTF-8  
ENV LC_ALL=en_US.UTF-8  

USER errbot:errbot

RUN python3 -m pip install --user --upgrade pip
RUN python3 -m pip install --user
RUN python3 -m pip install --user errbot

WORKDIR /srv/errbot-root

RUN errbot --init
