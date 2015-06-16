require 'logger'
require 'fluent-logger'


require './lib/slack_logger/client'
require './lib/slack_logger/user'
require './lib/slack_logger/channel'

module SlackLogger
  class Bot

    def initialize(slack_token: nil)
      @log = Logger.new(STDOUT)
      @log.debug "initialize"

      @log.debug "slack_token: #{slack_token}"
      @fluentd = Fluent::Logger::FluentLogger.new('slack', :host=>'localhost', :port=>24224)
    end

    def exec
      @log.debug "exec"

      @log.debug User.get_name "U03NLLCA1"

      client = Client.instance.slack.realtime

      client.on :hello do
        # Slack successfull connected ...
        @log.info 'Successfully connected.'
      end

      client.on :message do |data|
        @log.info data

        # data["text"] が無いものが通常の発言文字
        # data["message"] があるとurlを貼ったあとの要約
        # data["subtype"] があるとイベントっぽいの

        if text = data["text"]
          user_id   = data["user"]
          user_name = User.get_name(user_id)

          channel_id   = data["channel"]
          channel_name = Channel.get_name(channel_id)

          ts = Time.at(data["ts"].to_f).iso8601

          team_id = data["team"]

          @log.debug "ts: #{ts}, user_id: #{user_id}, user_name: #{user_name}, " +
            "channel_id: #{channel_id}, channel_name: #{channel_name} " +
            "text: #{text}"

          @fluentd.post("cloudnpaas",
            {
              ts:           ts,
              user_id:      user_id,
              user_name:    user_name,
              channel_id:   channel_id,
              channel_name: channel_name,
              text:         text,
            })

        else
          @log.debug "text ga nai"

        end

        # case data['text']
        #   when 'gamebot hi'
        #     Slack.chat_postMessage channel: data['channel'], text: "Hi <@#{data.user}>!"
        #   when /^gamebot/
        #     Slack.chat_postMessage channel: data['channel'], text: "Sorry <@#{data.user}>, what?"
        #   end
        # end
      end

      client.start
    end

  end
end
