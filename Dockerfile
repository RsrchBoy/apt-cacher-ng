FROM ubuntu:precise

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# waaaaaaaaaaay newer apt-cacher-ng
RUN echo "deb http://ppa.launchpad.net/pi-rho/dev/ubuntu precise main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3823B5A8A54746CA6CBED237CC892FC6779C27D7
RUN apt-get update && apt-get -y upgrade && apt-get -y install apt-cacher-ng

RUN echo "Acquire::http { Proxy \"http://127.0.0.1:3142\"; };"| tee -a /etc/apt/apt.conf.d/01proxy
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/cache/apt-cacher-ng", "/var/log/apt-cacher-ng"]

ENTRYPOINT ["/usr/sbin/apt-cacher-ng", "ForeGround=1"]

EXPOSE 3142
