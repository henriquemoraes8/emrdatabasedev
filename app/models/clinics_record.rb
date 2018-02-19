class ClinicsRecord < ApplicationRecord
  belongs_to :clinic
  belongs_to :record
end
