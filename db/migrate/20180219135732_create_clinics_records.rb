class CreateClinicsRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :clinics_records do |t|
      t.references :clinic, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps
    end
  end
end
