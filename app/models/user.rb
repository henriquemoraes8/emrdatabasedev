class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :share_requests, :dependent => :destroy
  has_many :records, -> {order 'created_at DESC'}, :dependent => :destroy
  has_one :address, :dependent => :destroy
  has_one :validation, :dependent => :destroy
  belongs_to :insurance, :optional => true

  enum status: [:inactive, :active]

  before_save :default_values

  scope :search, -> (name, phone, email, social) {
    name_query = "%#{name.nil? ? "" : name.downcase}%"
    phone_query = "%#{phone.nil? ? "" : phone.downcase}%"
    email_query = "%#{email.nil? ? "" : email.downcase}%"
    social_query = "%#{social.nil? ? "" : social.downcase}%"
    where("lower(name) like ? AND phone like ? AND lower(email) like ? AND social like ?", name_query, phone_query, email_query, social_query)
  }

  def clinics
    result = []
    records.includes(:owner_clinic).each do |r|
      result.append(r.owner_clinic)
    end
    result.uniq
  end

  def phone_digits
    phone.scan(/\d/).join('')
  end

  private

  def default_values
    self.status ||= User.statuses[:inactive]
  end

end
