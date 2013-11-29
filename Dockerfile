FROM stackbrew/ubuntu:saucy
 
RUN apt-get update && apt-get install -y apt-cacher-ng
RUN echo "Acquire::http { Proxy \"http://127.0.0.1:3142\"; };"| tee -a /etc/apt/apt.conf.d/01proxy

ENTRYPOINT ["/usr/sbin/apt-cacher-ng", "ForeGround=1"]
 
EXPOSE 3142
