FROM ruby:latest

WORKDIR /data

RUN \
  apt-get update && \
  apt-get install -yq git && \
  rm -rf /var/lib/apt/lists/*

RUN \
  git clone https://github.com/k-kurumi/slacklogger.git && \
  cd slacklogger && \
  gem install bundler && \
  bundle install --path=vendor/bundle

COPY myecho.sh /data/myecho.sh
RUN chmod +x myecho.sh

CMD ./myecho.sh
