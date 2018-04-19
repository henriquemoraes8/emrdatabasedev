class Policy < ApplicationRecord
  belongs_to :user
  belongs_to :insurance
  belongs_to :policy_group, :optional => true

  validates :policy_number, uniqueness: { scope: :insurance_id }

end
