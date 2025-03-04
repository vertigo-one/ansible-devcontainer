#build Ansible environemnt
FROM ubuntu:jammy


ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home
ENV LANG=C.UTF-8
ENV PS1="\[\e]0;\u@\h: \w\a\]\[\e[m\]\[\e[32m\]\u\[\e[m\]\[\e[01;34m\]@\[\e[m\]\[\e[33m\]ansible-\h\[\e[m\]:\[\e[01;34m\]\w\[\e[m\]\[\e[1m\]\$ \[\e[0m\]"
ENV SHELL=/bin/bash

ENV pip_packages="vcert ansible cryptography"

RUN mkdir -p $HOME/.config \
    mkdir -p $HOME/.local/bin \
    mkdir -p $HOME/.setup

COPY scripts ./scripts/
COPY .bashrc $HOME/.bashrc
COPY .profile $HOME/.profile
COPY requirements.yml $HOME/.setup/requirements.yml

# install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        wget \
        curl \
        jq \
        git\
        lsb-release \
        python3 \
        python3-pip \
        unzip \
        zip \
        bash \
        nano \
        openssl \
        iputils-tracepath \
        iputils-ping \
        byobu \
        bash-completion \
    && apt-get clean


RUN pip install --upgrade pip \
    && pip install $pip_packages \
    && pip install ansible

RUN ansible-galaxy install -r "$HOME/.setup/requirements.yml"

#install additional tools 
RUN chmod +x -R ./scripts/ &&\
    ./scripts/get-vcert.sh &&\
    ./scripts/updatevssh.sh &&\
    ./scripts/trustpki.sh && \
    rm -rf ./scripts/

ENTRYPOINT [ "/bin/bash" ]