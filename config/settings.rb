# frozen_string_literal: true

module Scoutatt
  class Settings < Hanami::Settings
    setting :session_secret, constructor: Types::String
  end
end
