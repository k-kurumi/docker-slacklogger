require 'slack'
require 'logger'

require 'pry'

logger = Logger.new(STDOUT)

SLACK_TOKEN = ENV['SLACK_TOKEN']

Slack.configure do |config|
  config.token = SLACK_TOKEN
end

auth = Slack.auth_test
fail auth['error'] unless auth['ok']


client = Slack.realtime

client.on :hello do
  # Slack successfull connected ...
  logger.info 'Successfully connected.'
end

client.on :message do |data|
  logger.info data
  # case data['text']
  #   when 'gamebot hi'
  #     Slack.chat_postMessage channel: data['channel'], text: "Hi <@#{data.user}>!"
  #   when /^gamebot/
  #     Slack.chat_postMessage channel: data['channel'], text: "Sorry <@#{data.user}>, what?"
  #   end
  # end
end

client.start
