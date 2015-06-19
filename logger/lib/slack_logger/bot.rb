require 'logger'
require 'fluent-logger'
require 'cgi'

require './lib/slack_logger/client'
require './lib/slack_logger/user'
require './lib/slack_logger/channel'
require './lib/slack_logger/config'

module SlackLogger
  class Bot

    def initialize
      @log = Logger.new(STDOUT)
      @log.debug "initialize"

      fluentd_host = Config.get(:fluentd_host)
      fluentd_port = Config.get(:fluentd_port)
      @tag         = Config.get(:fluentd_tag)

      @fluentd = Fluent::Logger::FluentLogger.new('slack', :host => fluentd_host, :port => fluentd_port)

      @log.debug "slack_token: #{Config.get(:slack_token)}"
    end

    def exec
      @log.debug "exec"

      client = Client.instance.slack.realtime

      client.on :hello do
        @log.info 'Successfully connected.'
      end

      client.on :message do |data|
        @log.info data

        # data["text"] が無いものが通常の発言文字
        # data["message"] があるとurlを貼ったあとの要約
        # data["subtype"] があるとイベントっぽいの

        # 全部で20以上あるので必要そうなのだけ使う
        case data["subtype"]
        when "bot_message"
          # bot(ユーザ一覧に出ないもの)の発言
          post(for_bot(data))

        when nil
          # ユーザ(hubot含む)の発言
          post(for_user(data))

        else
          # それ以外は無視する(URLの要約、ファイルの添付など)
          @log.debug "pass!!"
          next
        end

      end

      client.start
    end

    private

    def for_user(data)
      # ユーザ(hubot含む)の発言を整形する
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
        "@#{uname}"
      end

      # @channel -> @!channel展開されているものを戻す
      text.gsub!(/<![a-zA-Z0-9]+>/) do |m|
        cname = m.match(/[a-zA-Z0-9]+/)[0]
        "@#{cname}"
      end

      text = CGI.unescapeHTML(text)

      return {
        ts:           ts,
        user_id:      user_id,
        user_name:    user_name,
        channel_id:   channel_id,
        channel_name: channel_name,
        text:         text,
      }
    end

    def for_bot(data)
      # bot(ユーザ一覧に出ないもの)の発言を整形する
      ts = Time.at(data["ts"].to_f).iso8601

      user_id = data["bot_id"]
      user_name = data["username"]  # usernaemがないbotもある

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

      text = CGI.unescapeHTML(text)

      return {
        ts:           ts,
        user_id:      user_id,
        user_name:    user_name,
        channel_id:   channel_id,
        channel_name: channel_name,
        text:         text,
      }
    end

    def post(log_data)
      # NOTE: log_data format
      # {
      #   ts:           "発言日時(ISO8601)",
      #   user_id:      "発言ユーザID",
      #   user_name:    "発言ユーザ名",
      #   channel_id:   "発言チャンネルのID",
      #   channel_name: "発言チャンネル名",
      #   text:         "発言内容",
      # }

      @log.debug "post #{log_data}"
      @fluentd.post(@tag, log_data)
    end

  end
end
