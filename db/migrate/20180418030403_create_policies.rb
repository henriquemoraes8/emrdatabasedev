class CreatePolicies < ActiveRecord::Migration[5.1]
  def change
    create_table :policies do |t|
      t.references :user, foreign_key: true
      t.references :insurance, foreign_key: true
      t.string :policy_number
      t.references :policy_group, foreign_key: true

      t.timestamps
    end
  end
end
