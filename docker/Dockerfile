FROM ubuntu:16.04

LABEL maintainer="YiJun Chen <gzenux@gmail.com>"


# install basic packages
RUN apt-get update && apt-get install -y locales sudo

# install required packages
RUN apt-get update && apt-get install -y \
	build-essential \
	flex \
	gawk g++-multilib gettext git \
	python \
	quilt \
	subversion \
	unzip \
	wget \
	libncurses5-dev zlib1g-dev


# get arguments
ARG UID=1000
ARG USER=user
ARG HOME=/home/${USER}
ARG LANG=en_US.UTF-8
ARG LANGUAGES="zh_TW.UTF-8 ${LANG}"

# set environment variables
ENV USER ${USER}
ENV LANG ${LANG}
ENV LANGUAGE ${LANG}


# generate locale
RUN locale-gen $LANGUAGES

# use bash as default shell
RUN echo "dash dash/sh boolean false" | debconf-set-selections && dpkg-reconfigure -f noninteractive dash

# Add user and switch to the user
RUN mkdir -p $(dirname ${HOME}) && useradd -m -u ${UID} -d ${HOME} ${USER} && passwd -d ${USER} && \
gpasswd -a ${USER} sudo && sed -i 's:%sudo\tALL=(ALL\:ALL) ALL:%sudo\tALL=NOPASSWD\: ALL:g' /etc/sudoers


USER ${USER}
WORKDIR ${HOME}

CMD ["/bin/bash"]
