object @record
attributes :id, :url, :mime_type, :name, :created_at

child :record_types, :object_root => false do
    extends('record_types/show_simple')
end

unless @clinic.nil?
    node (:can_edit) { |r| @clinic.owned_records.include?(r) }
end