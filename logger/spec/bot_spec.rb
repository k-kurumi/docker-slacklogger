require 'spec_helper'

describe "Bot" do
  before do
    allow(SlackLogger::User).to receive(:get_name).and_return("user1")
    allow(SlackLogger::Channel).to receive(:get_name).and_return("channel1")
  end

  let(:logbot) { SlackLogger::Bot.new }

  describe "for_user" do
    let(:data_user) do
      {"type"=>"message", "channel"=>"cid1", "user"=>"uid1",
       "text"=>"もじもじ", "ts"=>"1434701526.000022", "team"=>"TTTTT"}
    end

    let(:data_user_parsed) do
      {:ts=>"2015-06-19T17:12:06+09:00", :user_id=>"uid1", :user_name=>"user1",
       :channel_id=>"cid1", :channel_name=>"channel1", :text=>"もじもじ"}
    end

    it "valid data" do
      expect(logbot.__send__(:for_user, data_user)).to eq data_user_parsed
    end
  end

  describe "for_bot" do
    let(:data_bot) do
      {"text"=>"(◔౪◔ ) ｫｵ? 17時だよ。", "username"=>"jenkins", "bot_id"=>"BBBB",
       "icons"=>{"emoji"=>":jenkins:"}, "type"=>"message", "subtype"=>"bot_message",
       "channel"=>"cid1", "ts"=> "1434700803.007719"}
    end

    let(:data_bot_parsed) do
      {:ts=>"2015-06-19T17:00:03+09:00", :user_id=>"BBBB", :user_name=>"jenkins",
       :channel_id=>"cid1", :channel_name=>"channel1", :text=>"(◔౪◔ ) ｫｵ? 17時だよ。"}
    end

    it "valid data" do
      expect(logbot.__send__(:for_bot, data_bot)).to eq data_bot_parsed
    end
  end

end
