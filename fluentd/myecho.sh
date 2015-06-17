#!/bin/bash

env

# kibana_1        | ELASTICSEARCH_1_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_1_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_1_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_1_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_1_NAME=/elasticsearch_kibana_1/elasticsearch_1
# kibana_1        | ELASTICSEARCH_1_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_NAME=/elasticsearch_kibana_1/elasticsearch_elasticsearch_1
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_NAME=/elasticsearch_kibana_1/elasticsearch
# kibana_1        | ELASTICSEARCH_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_PROTO=tcp


# NOTE dockerホスト宛にforwardするとき、sender側はheartbeat_type tcpを指定すること
cat << __EOL__ > /data/fluentd.conf
<source>
  @type forward
  @id forward_input
</source>

<match slack.**>
  @type copy
  <store>
    @type stdout
  </store>
  <store>
    @type elasticsearch
    index_name fluentd
    type_name slack
    tag_key @log_name
    include_tag_key true
    logstash_format true
    logstash_prefix slack
    host ${ELASTICSEARCH_PORT_9300_TCP_ADDR}
    port ${ELASTICSEARCH_PORT_9200_TCP_PORT}
    flush_interval 10s
  </store>
  <store>
    @type file
    path /data/mount/slacklog
    append true
    time_slice_format %Y%m%d
    time_slice_wait 10m
    compress gzip
  </store>
</match>
__EOL__

echo "start fluentd"
fluentd --config /data/fluentd.conf
