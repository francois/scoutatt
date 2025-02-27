# frozen_string_literal: true

require "hanami"

module Scoutatt
  class App < Hanami::App
    config.actions.sessions = :cookie, {
      key: "bookshelf.session",
      secret: settings.session_secret,
      expire_after: 60 * 60 * 24 * 365 # 1 year, in seconds
    }
  end
end
