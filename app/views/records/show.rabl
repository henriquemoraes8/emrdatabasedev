object @record
attributes :id, :url, :mime_type, :name

child :record_types, :object_root => false do
    extends('record_types/show_simple')
end