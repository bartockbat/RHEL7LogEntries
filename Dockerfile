# docker-logentries
#
# VERSION 0.2.0
FROM registry.access.redhat.com/rhel7
#FROM registry-rhconnect.rhcloud.com/rhel71_updates
MAINTAINER Redhat
#USER root
# install dev tools
RUN yum clean all; \
rpm --rebuilddb; \
yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum -y groupinstall "Development Tools"
RUN yum -y install initscripts
RUN yum -y install nodejs.x86_64


RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app

# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

ENTRYPOINT ["/usr/src/app/index.js"]
CMD []
