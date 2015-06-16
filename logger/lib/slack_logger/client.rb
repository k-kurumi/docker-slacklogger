require 'slack'
require 'singleton'

module SlackLogger
  class Client
    include Singleton

    def initialize
      Slack.configure do |config|
        config.token = ENV['SLACK_TOKEN']
      end
      auth = Slack.auth_test
      fail auth['error'] unless auth['ok']
    end

    def slack
      Slack
    end

  end
end
