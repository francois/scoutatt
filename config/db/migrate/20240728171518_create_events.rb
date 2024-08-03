# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :events do
      primary_key :id
      foreign_key :season_id, null: false
      column :slug, :text, null: false
      column :title, :text, null: false
      column :max_registrations, :integer, null: false
      column :start_at, :datetime, null: false

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :slug, unique: true
      index %w[season_id]
    end
  end
end
