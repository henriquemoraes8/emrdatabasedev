class AddTokenToShareRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :share_requests, :token, :string, {unique: true, null: false}
  end
end
