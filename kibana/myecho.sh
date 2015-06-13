#!/bin/bash

env

# kibana4_1       | KIBANA_VERSION=4.0.2
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


cat << __EOL__ > /data/kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml
# Kibana is served by a back end server. This controls which port to use.
port: 5601

# The host to bind the server to.
host: "0.0.0.0"

# The Elasticsearch instance to use for all your queries.
#elasticsearch_url: "http://localhost:9200"
elasticsearch_url: "http://${ELASTICSEARCH_PORT_9200_TCP_ADDR}:${ELASTICSEARCH_PORT_9200_TCP_PORT}"

# preserve_elasticsearch_host true will send the hostname specified in \`elasticsearch\`. If you set it to false,
# then the host you use to connect to *this* Kibana instance will be sent.
elasticsearch_preserve_host: true

# Kibana uses an index in Elasticsearch to store saved searches, visualizations
# and dashboards. It will create a new index if it doesn't already exist.
kibana_index: ".kibana"

# If your Elasticsearch is protected with basic auth, this is the user credentials
# used by the Kibana server to perform maintence on the kibana_index at statup. Your Kibana
# users will still need to authenticate with Elasticsearch (which is proxied thorugh
# the Kibana server)
# kibana_elasticsearch_username: user
# kibana_elasticsearch_password: pass

# If your Elasticsearch requires client certificate and key
# kibana_elasticsearch_client_crt: /path/to/your/client.crt
# kibana_elasticsearch_client_key: /path/to/your/client.key

# If you need to provide a CA certificate for your Elasticsarech instance, put
# the path of the pem file here.
# ca: /path/to/your/CA.pem

# The default application to load.
default_app_id: "discover"

# Time in milliseconds to wait for responses from the back end or elasticsearch.
# This must be > 0
request_timeout: 300000

# Time in milliseconds for Elasticsearch to wait for responses from shards.
# Set to 0 to disable.
shard_timeout: 0

# Set to false to have a complete disregard for the validity of the SSL
# certificate.
verify_ssl: true

# SSL for outgoing requests from the Kibana Server (PEM formatted)
# ssl_key_file: /path/to/your/server.key
# ssl_cert_file: /path/to/your/server.crt

# Set the path to where you would like the process id file to be created.
# pid_file: /var/run/kibana.pid

# Plugins that are included in the build, and no longer found in the plugins/ folder
bundled_plugin_ids:
 - plugins/dashboard/index
 - plugins/discover/index
 - plugins/doc/index
 - plugins/kibana/index
 - plugins/markdown_vis/index
 - plugins/metric_vis/index
 - plugins/settings/index
 - plugins/table_vis/index
 - plugins/vis_types/index
 - plugins/visualize/index
__EOL__


echo "start kibana4"
./kibana-${KIBANA_VERSION}-linux-x64/bin/kibana
