# auto_register: false
# frozen_string_literal: true

require 'tzinfo'

module Scoutatt
  module Views
    module Helpers
      def time(timestamp, timezone:)
        format = '%Y-%m-%dT%H:%M:%S%z'
        tz = TZInfo::Timezone.get(timezone)
        tsutc = timestamp.utc
        tag.time(datetime: tsutc.strftime(format), title: tz.utc_to_local(tsutc).strftime(format)) do
          tz.utc_to_local(tsutc).strftime('%-d %-b %Y, %H:%M')
        end
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
