class ShareRequest < ApplicationRecord
  belongs_to :user
  belongs_to :clinic

  enum status: [:pending, :approved, :denied]

  before_create :default_values, :generate_token

  protected

  def default_values
    self.status ||= ShareRequest.statuses[:pending]
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless ShareRequest.exists?(token: random_token)
    end
  end

end
