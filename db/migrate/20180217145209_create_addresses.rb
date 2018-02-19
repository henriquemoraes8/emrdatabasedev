class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zip
      t.string :state
      t.string :city
      t.string :apt

      t.timestamps
    end
  end
end
