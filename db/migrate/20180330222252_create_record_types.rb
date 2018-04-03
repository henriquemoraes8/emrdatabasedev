class CreateRecordTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :record_types do |t|
      t.string :name
      t.references :parent, references: :record_types, index: true, null: true

      t.timestamps
    end
  end
end
