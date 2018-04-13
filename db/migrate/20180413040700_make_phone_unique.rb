class MakePhoneUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :phone, unique: true
    add_index :clinics, :phone, unique: true
    add_index :insurances, :phone, unique: true
  end
end
