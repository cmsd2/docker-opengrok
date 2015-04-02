FROM ubuntu:14.04
MAINTAINER Zero Cho "http://itsze.ro/"

ENV OPENGROK_INSTANCE_BASE /grok

RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless exuberant-ctags git subversion mercurial tomcat7 wget inotify-tools
ADD install.sh /usr/local/bin/install
RUN /usr/local/bin/install
ADD run.sh /usr/local/bin/run
ADD hgrc /etc/mercurial/hgrc

ENV JAVA_OPTS -server -Xmx14000M -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=25

CMD ["/usr/local/bin/run"]

EXPOSE 8080
