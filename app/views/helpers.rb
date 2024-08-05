# auto_register: false
# frozen_string_literal: true

module Scoutatt
  module Views
    module Helpers
      def time(timestamp, format: '%Y-%m-%dT%H:%M:%S%z')
        timestamp.strftime(format)
      end

      def titleize(string)
        match = string.match(/^(.)(.*)/)
        "#{match[1].upcase}#{match[2]}"
      end

      def debug(value)
        tag.pre do
          tag.code do
            JSON.pretty_generate(value.to_h)
          end
        end
      end
    end
  end
end
