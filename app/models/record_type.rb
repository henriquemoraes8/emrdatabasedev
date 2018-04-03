class RecordType < ApplicationRecord

  belongs_to :parent, :class_name => 'RecordType', optional: true
  has_many :subtypes, -> {order 'name'}, :class_name => 'RecordType', foreign_key: 'parent_id'
  has_and_belongs_to_many :records

  scope :top_types, -> {
    RecordType.where(parent_id: nil)
  }

end
