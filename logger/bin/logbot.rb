require './lib/slack_logger/bot'

require 'pry'

SLACK_TOKEN = ENV['SLACK_TOKEN']

FLUENTD_HOST = ENV['FLUENTD_HOST']
FLUENTD_PORT = ENV['FLUENTD_PORT']
FLUENTD_TAG  = ENV['FLUENTD_TAG']

logger = SlackLogger::Bot.new(
  slack_token:  SLACK_TOKEN,
  fluentd_host: FLUENTD_HOST,
  fluentd_port: FLUENTD_PORT,
  fluentd_tag:  FLUENTD_TAG
)

logger.exec
