# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :seasons do
      primary_key :id

      column :title, :text, null: false
      column :slug, :text, null: false

      column :created_at, :timestamp, null: false
      column :updated_at, :timestamp, null: false

      index :slug, unique: true
      index :title
    end
  end
end
