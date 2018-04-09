object @clinic
attributes :id, :name, :email, :phone

unless @user.nil?
    node (:record_count) { |c| c.owned_records.where(user_id: @user.id).count }
    node (:last_update) { |c| c.owned_records.where(user_id: @user.id).count == 0 ? nil : c.owned_records.where(user_id: @user.id).first.created_at }
end

child (:address) { extends('addresses/show') }