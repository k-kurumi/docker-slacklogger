require 'singleton'

module SlackLogger
  class Config
    @@config = {}

    class << self
      def set(hash)
        @@config = hash
      end

      def get(key)
        @@config[key]
      end

      def get_all
        @@config
      end
    end

  end
end
