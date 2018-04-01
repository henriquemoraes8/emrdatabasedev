object @record
attributes :id, :url, :mime_type, :name

node (:record_type) { |r| r.record_type.name }