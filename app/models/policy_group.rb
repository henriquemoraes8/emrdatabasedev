class PolicyGroup < ApplicationRecord
  belongs_to :insurance
  has_many :policies
end
