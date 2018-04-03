class CreateRecordTypesRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :record_types_records do |t|
      t.references :record, foreign_key: true
      t.references :record_type, foreign_key: true

      t.timestamps
    end
  end
end
