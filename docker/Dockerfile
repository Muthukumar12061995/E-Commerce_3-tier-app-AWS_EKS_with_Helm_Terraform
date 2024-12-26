FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-client

RUN mkdir /root/.ssh

COPY master /root/.ssh/id_rsa

RUN chmod 700 /root/.ssh

RUN chmod 600 /root/.ssh/id_rsa

CMD ["sleep","infinity"]	
