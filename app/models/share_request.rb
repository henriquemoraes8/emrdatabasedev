class ShareRequest < ApplicationRecord
  belongs_to :user
  belongs_to :clinic

  enum status: [:pending, :approved, :denied]
end
