class ShareRequest < ApplicationRecord
  belongs_to :user
  belongs_to :clinic

  enum status: [:pending, :approved, :denied]

  before_create :default_values, :generate_token
  before_update :prevent_update

  protected

  def default_values
    self.status ||= ShareRequest.statuses[:pending]
    self.is_patient = true if self.is_patient.nil?
    self.password ||= SecureRandom.hex(4)
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless ShareRequest.exists?(token: random_token)
    end
  end

  def prevent_update
    return true if self.status == ShareRequest.statuses[:pending]
    errors.add(:status, :cannot_change, message: "request is untamperable")
    false
  end

end
