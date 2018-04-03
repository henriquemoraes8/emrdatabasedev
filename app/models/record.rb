class Record < ApplicationRecord
  belongs_to :user
  belongs_to :owner_clinic, :class_name => 'Clinic', :foreign_key => 'clinic_id'
  has_and_belongs_to_many :clinics
  has_and_belongs_to_many :record_types

  scope :by_types, -> (type_ids) {
    joins(:record_types).where(record_types: {id: type_ids} )
  }

end
