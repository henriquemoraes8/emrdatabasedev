class RecordTypesRecord < ApplicationRecord
  belongs_to :record
  belongs_to :record_type
end
