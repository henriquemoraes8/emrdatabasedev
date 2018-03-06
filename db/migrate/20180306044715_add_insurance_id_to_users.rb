class AddInsuranceIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :insurance, foreign_key: true
  end
end
