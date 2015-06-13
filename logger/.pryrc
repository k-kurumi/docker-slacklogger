require 'fluent-logger'

log = Fluent::Logger::FluentLogger.new('slack', :host=>'localhost', :port=>24224)
#
#
# log.post("zz", {message: "新しい日時フォーマットテストzz14", ts: Time.at("1434209029.000006".to_f).iso8601})
