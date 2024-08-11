# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "dry/monads"

module Scoutatt
  class Action < Hanami::Action
    # Provide `Success` and `Failure` for pattern matching on operation results
    include Dry::Monads[:result]
    include Deps['logger']

    handle_exception StandardError => :handle_standard_error

    def handle_standard_error(request, response, exception)
      if Hanami.env?(:development)
        raise exception
      else
        logger.error do
          {
            class_name: exception.class.name,
            message: exception.message,
            backtrace: exception.backtrace
          }.to_json
        end

        response.status = 500
        response.body = "Sorry, something went wrong handling your request"
      end
    end
  end
end
