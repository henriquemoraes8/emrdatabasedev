class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :social
      t.string :email
      t.string :phone
      t.date :birth_date
      t.integer :status

      t.timestamps
    end
    add_index :users, :social, unique: true
    add_index :users, :email, unique: true
  end
end
