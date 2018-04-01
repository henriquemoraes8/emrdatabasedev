object @record_type
attributes :id, :name

node (:subtypes) { |r| partial('record_types/index',:object => r.subtypes) }