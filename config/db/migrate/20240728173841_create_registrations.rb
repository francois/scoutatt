# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :registrations do
      primary_key :id
      foreign_key :event_id, null: false
      column :name, :text, null: false
      column :role, :text, null: false

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index %i[event_id name]
    end
  end
end
