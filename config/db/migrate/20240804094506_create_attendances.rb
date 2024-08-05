# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :attendances do
      primary_key :id
      foreign_key :event_id, null: false, on_update: :cascade, on_delete: :cascade

      column :slug, :text, null: false
      column :name, :text, null: false
      column :role, :text, null: false
      column :presented_at, :timestamp

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index %i[event_id name]
      index %i[slug], unique: true
    end
  end
end
