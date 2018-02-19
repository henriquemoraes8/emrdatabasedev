class CreateInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :insurances do |t|
      t.string :phone
      t.string :name
      t.string :email
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
