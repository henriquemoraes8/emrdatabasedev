class CreateValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :validations do |t|
      t.datetime :expiration
      t.references :user, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
