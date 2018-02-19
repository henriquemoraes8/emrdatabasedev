class CreateClinics < ActiveRecord::Migration[5.1]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
