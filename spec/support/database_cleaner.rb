# frozen_string_literal: true

require "database_cleaner-sequel"

# Allow Database Cleaner to work on our local sqlite databases
DatabaseCleaner.url_allowlist = [%r{^sqlite://}]

Hanami.app.prepare :db
DatabaseCleaner[:sequel]

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, type: :db) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
