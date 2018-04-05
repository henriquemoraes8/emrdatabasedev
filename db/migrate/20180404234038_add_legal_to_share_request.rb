class AddLegalToShareRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :share_requests, :is_patient, :boolean
    add_column :share_requests, :legal_rep_name, :string
    add_column :share_requests, :legal_rep_relation, :string
  end
end
