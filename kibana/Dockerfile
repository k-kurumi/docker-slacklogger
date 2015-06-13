FROM ubuntu:14.04

ENV KIBANA_VERSION=4.1.0

WORKDIR /data

RUN \
  apt-get update && \
  apt-get install -yq wget curl && \
  rm -rf /var/lib/apt/lists/*

RUN \
  wget https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
  tar zxvf kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
  rm kibana-${KIBANA_VERSION}-linux-x64.tar.gz

COPY myecho.sh /data/myecho.sh
RUN chmod +x myecho.sh

EXPOSE 5601

CMD ./myecho.sh
