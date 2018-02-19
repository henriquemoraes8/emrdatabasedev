class CreateShareRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :share_requests do |t|
      t.integer :status
      t.references :user, foreign_key: true
      t.references :clinic, foreign_key: true

      t.timestamps
    end
  end
end
