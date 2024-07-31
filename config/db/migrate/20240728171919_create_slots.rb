# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :slots do
      primary_key :id
      foreign_key :event_id, null: false
      column :slug, :text, null: false
      column :start_at, :timestamp, null: false
      column :num_registrations, :integer, null: false, default: 1

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :slug, unique: true
      index %w[event_id start_at], unique: true
    end
  end
end
