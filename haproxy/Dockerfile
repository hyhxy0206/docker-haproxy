FROM centos
LABEL MAINTAINER='xxx 1@2.com'

ENV version 2.4.9
ENV PATH /usr/local/harpoxy/sbin:$PATH
ENV RSs ""

COPY files /usr/src/
COPY entrypoint.sh /

RUN ["/bin/bash","-c","/usr/src/install.sh"]

WORKDIR /usr/local/haproxy
EXPOSE 8189 80

ENTRYPOINT ["/entrypoint.sh"]

