FROM ruby:latest

WORKDIR /data

RUN \
  apt-get update && \
  apt-get install -yq curl && \
  rm -rf /var/lib/apt/lists/*

RUN \
  gem install fluentd --no-ri --no-rdoc && \
  fluent-gem install fluent-plugin-elasticsearch

COPY myecho.sh /data/myecho.sh
RUN chmod +x myecho.sh

EXPOSE 24224

CMD ./myecho.sh
