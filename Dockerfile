FROM ubuntu:16.04

MAINTAINER Reggie Davis <reggied@blinds.com> 

ENV EB_USER errbot

RUN groupadd -r $EB_USER && useradd -g errbot -d /srv/errbot-root $EB_USER

RUN apt-get -y update
RUN apt-get -y install python python3-pip git locales

# Set default locale for the environment
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US.UTF-8  
ENV LC_ALL=en_US.UTF-8  

RUN python3 -m pip install --upgrade pip setuptools
RUN python3 -m pip install virtualenv

RUN mkdir -p /srv/errbot-root/app && chown -R $EB_USER /srv/errbot-root/

USER $EB_USER
WORKDIR /srv/errbot-root

COPY requirements.txt ./app/requirements.txt

# Creates the Python virtual env & installs packages from the requirements.txt
RUN python3 -m virtualenv ./app/env
RUN . ./app/env/bin/activate
RUN python3 -m pip install --user -r ./app/requirements.txt

ENV PATH "$PATH:/srv/errbot-root/.local/bin/"

RUN errbot --init
