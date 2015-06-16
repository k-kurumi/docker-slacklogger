require 'fluent-logger'

log = Fluent::Logger::FluentLogger.new('slack', :host=>'localhost', :port=>24224)
#
#
# log.post("zz", {message: "新しい日時フォーマットテストzz14", ts: Time.at("1434209029.000006".to_f).iso8601})
#



require 'slack'
SLACK_TOKEN = ENV['SLACK_TOKEN']
Slack.configure do |config|
  config.token = SLACK_TOKEN
end

auth = Slack.auth_test
fail auth['error'] unless auth['ok']


# 動的に作っている模様
# Slack.users_list


require './lib/slack_logger/user'
require './lib/slack_logger/channel'
