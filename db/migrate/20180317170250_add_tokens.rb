class AddTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :authentication_token, :text
    add_column :insurances, :authentication_token_created_at, :datetime

    add_index :insurances, :authentication_token, unique: true

    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime

    add_index :users, :authentication_token, unique: true

    add_column :clinics, :authentication_token, :text
    add_column :clinics, :authentication_token_created_at, :datetime

    add_index :clinics, :authentication_token, unique: true
  end
end
