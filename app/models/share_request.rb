class ShareRequest < ApplicationRecord
  belongs_to :user
  belongs_to :clinic

  enum status: [:pending, :approved, :denied]

  before_save :default_values

  def default_values
    self.status ||= ShareRequest.statuses[:pending]
  end

end
