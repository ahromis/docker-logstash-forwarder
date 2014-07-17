FROM stackbrew/ubuntu:14.04
MAINTAINER Andrew Hromis "ahromis@gmail.com"

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH

RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /opt/logstash-forwarder
RUN cd /opt/logstash-forwarder && go build

RUN mkdir /etc/logstash-forwarder
RUN mkdir /containers

CMD ["/opt/logstash-forwarder/logstash-forwarder","-config","/etc/logstash-forwarder/logstash-forwarder.json"]
