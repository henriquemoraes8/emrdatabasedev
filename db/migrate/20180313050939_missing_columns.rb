class MissingColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :insurance_unique_id, :string
    add_column :records, :name, :string
    add_column :records, :mime_type, :string
  end
end
