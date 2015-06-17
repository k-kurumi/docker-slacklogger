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

        # 全部で20以上あるので必要そうなのだけ使う
        case data["subtype"]
        when "message_changed"
          # urlを貼った後の要約、投稿済み発言の編集など
          #
        when "bot_message"
          # bot(ユーザ一覧に出ないもの)の発言
          # attachmentsのあるのとないのがいる
          ts = Time.at(data["ts"].to_f).iso8601

          user_id = data["bot_id"]
          user_name = data["username"]

          channel_id   = data["channel"]
          channel_name = Channel.get_name(channel_id)

          text = ""

          # botは2パターンあり
          # 1. text="" and attachmentsつき
          # 2. text="なにか" and attachmentsなし
          if data["attachments"]
            # jenkinsなど
            text = data["attachments"].map do |a|
              if a.has_key?("text")
                # githubコメント付き
                a["fallback"] + a["text"]
              else
                a["fallback"]
              end
            end
          else
            # まぐろなど
            text = data["text"]
          end

          @log.debug "ts: #{ts}, user_id: #{user_id}, user_name: #{user_name}, " +
            "channel_id: #{channel_id}, channel_name: #{channel_name} " +
            "text: #{text}"

        when nil
          # ユーザ(hubot含む)の発言
          ts = Time.at(data["ts"].to_f).iso8601

          user_id   = data["user"]
          user_name = User.get_name(user_id)

          channel_id   = data["channel"]
          channel_name = Channel.get_name(channel_id)

          text = data["text"]

          # NOTE botの発言は展開されていないため不要
          # @user_name->@user_id展開されているものを戻す
          text.gsub!(/<@([0-9A-Z])+>/) do |m|
            uid = m.match(/[0-9A-Z]+/)[0]
            uname = SlackLogger::User.get_name(uid)
            "<@#{uname}>"
          end

          # @channel -> @!channel展開されているものを戻す
          text.gsub!(/<![a-zA-Z0-9]+>/) do |m|
            cname = m.match(/[a-zA-Z0-9]+/)[0]
            "<@#{cname}>"
          end

          # NOTE SLACK_TOKENがbot扱いのためSlack.team_infoからチーム名の取得不可
          # NOTE botの発言にteamは無い
          #team_id = data["team"]

          @log.debug "ts: #{ts}, user_id: #{user_id}, user_name: #{user_name}, " +
            "channel_id: #{channel_id}, channel_name: #{channel_name} " +
            "text: #{text}"

        end

        @fluentd.post("cloudnpaas",
          {
            ts:           ts,
            user_id:      user_id,
            user_name:    user_name,
            channel_id:   channel_id,
            channel_name: channel_name,
            text:         text,
          })

      end

      client.start
    end

  end
end
