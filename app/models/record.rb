class Record < ApplicationRecord
  belongs_to :user
  belongs_to :owner_clinic, :class_name => 'Clinic', :foreign_key => 'clinic_id'
  has_and_belongs_to_many :clinics
  belongs_to :record_type
end
