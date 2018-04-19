class CreatePolicyGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_groups do |t|
      t.string :group_number
      t.references :insurance, foreign_key: true

      t.timestamps
    end
  end
end
