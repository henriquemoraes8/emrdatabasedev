collection @clinics, :root => "clinics", :object_root => false

extends('clinics/show')
unless @user.nil?
    node (:record_count) { |c| c.owned_records.where(user_id: @user.id).count }
    node (:last_update) { |c| c.owned_records.where(user_id: @user.id).first.created_at }
end