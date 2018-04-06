class AddFileSizeToRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :file_size, :int
  end
end
