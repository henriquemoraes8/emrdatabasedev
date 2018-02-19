class AddReferencesToAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :user, foreign_key: true
    add_reference :addresses, :clinic, foreign_key: true
    add_reference :addresses, :insurance, foreign_key: true
    add_reference :users, :address, foreign_key: true
    add_reference :clinics, :address, foreign_key: true
    add_reference :records, :clinic, foreign_key: true
  end
end
