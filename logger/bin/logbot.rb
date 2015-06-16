require './lib/slack_logger/bot'

require 'pry'

SLACK_TOKEN = ENV['SLACK_TOKEN']

logger = SlackLogger::Bot.new(slack_token: SLACK_TOKEN)
logger.exec
