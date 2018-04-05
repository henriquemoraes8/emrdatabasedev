class Validation < ApplicationRecord
  belongs_to :user

  before_create :verify_existing_validation

  private

  def verify_existing_validation
    old = Validation.find_by(user_id: user_id)
    old.destroy unless old.nil?
    self.expiration = DateTime.now + 1.hour
  end
end
