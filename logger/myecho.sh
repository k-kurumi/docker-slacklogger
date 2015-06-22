#!/bin/bash

env

# logger_1 | BUNDLE_APP_CONFIG=/usr/local/bundle
# logger_1 | BUNDLER_VERSION=1.10.3
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_BUNDLE_APP_CONFIG=/usr/local/bundle
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_BUNDLER_VERSION=1.10.3
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_GEM_HOME=/usr/local/bundle
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_OUT_HOME=/var/out_home
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_RUBY_DOWNLOAD_SHA256=5ffc0f317e429e6b29d4a98ac521c3ce65481bfd22a8cf845fa02a7b113d9b44
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_RUBY_MAJOR=2.2
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_ENV_RUBY_VERSION=2.2.2
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_NAME=/dockerslacklogger_logger_1/dockerslacklogger_fluentd_1
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_PORT_24224_TCP_ADDR=172.17.0.106
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_PORT_24224_TCP_PORT=24224
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_PORT_24224_TCP_PROTO=tcp
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_PORT_24224_TCP=tcp://172.17.0.106:24224
# logger_1 | DOCKERSLACKLOGGER_FLUENTD_1_PORT=tcp://172.17.0.106:24224
# logger_1 | FLUENTD_1_ENV_BUNDLE_APP_CONFIG=/usr/local/bundle
# logger_1 | FLUENTD_1_ENV_BUNDLER_VERSION=1.10.3
# logger_1 | FLUENTD_1_ENV_GEM_HOME=/usr/local/bundle
# logger_1 | FLUENTD_1_ENV_OUT_HOME=/var/out_home
# logger_1 | FLUENTD_1_ENV_RUBY_DOWNLOAD_SHA256=5ffc0f317e429e6b29d4a98ac521c3ce65481bfd22a8cf845fa02a7b113d9b44
# logger_1 | FLUENTD_1_ENV_RUBY_MAJOR=2.2
# logger_1 | FLUENTD_1_ENV_RUBY_VERSION=2.2.2
# logger_1 | FLUENTD_1_NAME=/dockerslacklogger_logger_1/fluentd_1
# logger_1 | FLUENTD_1_PORT_24224_TCP_ADDR=172.17.0.106
# logger_1 | FLUENTD_1_PORT_24224_TCP_PORT=24224
# logger_1 | FLUENTD_1_PORT_24224_TCP_PROTO=tcp
# logger_1 | FLUENTD_1_PORT_24224_TCP=tcp://172.17.0.106:24224
# logger_1 | FLUENTD_1_PORT=tcp://172.17.0.106:24224
# logger_1 | FLUENTD_ENV_BUNDLE_APP_CONFIG=/usr/local/bundle
# logger_1 | FLUENTD_ENV_BUNDLER_VERSION=1.10.3
# logger_1 | FLUENTD_ENV_GEM_HOME=/usr/local/bundle
# logger_1 | FLUENTD_ENV_OUT_HOME=/var/out_home
# logger_1 | FLUENTD_ENV_RUBY_DOWNLOAD_SHA256=5ffc0f317e429e6b29d4a98ac521c3ce65481bfd22a8cf845fa02a7b113d9b44
# logger_1 | FLUENTD_ENV_RUBY_MAJOR=2.2
# logger_1 | FLUENTD_ENV_RUBY_VERSION=2.2.2
# logger_1 | FLUENTD_NAME=/dockerslacklogger_logger_1/fluentd
# logger_1 | FLUENTD_PORT_24224_TCP_ADDR=172.17.0.106
# logger_1 | FLUENTD_PORT_24224_TCP_PORT=24224
# logger_1 | FLUENTD_PORT_24224_TCP_PROTO=tcp
# logger_1 | FLUENTD_PORT_24224_TCP=tcp://172.17.0.106:24224
# logger_1 | FLUENTD_PORT=tcp://172.17.0.106:24224
# logger_1 | GEM_HOME=/usr/local/bundle
# logger_1 | HOME=/root
# logger_1 | HOSTNAME=c92ae538344c
# logger_1 | PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# logger_1 | PWD=/data
# logger_1 | RUBY_DOWNLOAD_SHA256=5ffc0f317e429e6b29d4a98ac521c3ce65481bfd22a8cf845fa02a7b113d9b44
# logger_1 | RUBY_MAJOR=2.2
# logger_1 | RUBY_VERSION=2.2.2
# logger_1 | SHLVL=1
# logger_1 | _=/usr/bin/env

export FLUENTD_HOST=${FLUENTD_PORT_24224_TCP_ADDR}
export FLUENTD_PORT=${FLUENTD_PORT_24224_TCP_PORT}

echo "start slacklogger"
cd slacklogger
bundle exec ruby bin/logbot.rb
