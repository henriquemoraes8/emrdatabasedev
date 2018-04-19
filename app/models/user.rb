class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :share_requests, :dependent => :destroy
  has_many :records, -> {order 'created_at DESC'}, :dependent => :destroy
  has_one :address, :dependent => :destroy
  has_one :validation, :dependent => :destroy
  has_one :policy, :dependent => :destroy
  has_one :insurance, :through => :policy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :policy

  enum status: [:inactive, :active]

  before_create :default_values
  before_save :adjust_phone
  before_validation :guarantee_password

  scope :search, -> (name, phone, email) {
    name_query = "%#{name.nil? ? "" : name.downcase}%"
    phone_query = "%#{phone.nil? ? "" : phone.downcase}%"
    email_query = "%#{email.nil? ? "" : email.downcase}%"
    where("lower(name) like ? AND phone like ? AND lower(email) like ?", name_query, phone_query, email_query)
  }

  scope :birth_date_query, -> (start_date) { where birth_date: start_date.all_day }

  def clinics
    clinic_ids = share_requests.where(status: ShareRequest.statuses[:approved]).map {|r| r.clinic_id }
    Clinic.where(id: clinic_ids)
  end

  def social
    self[:social].nil? ? "" : self[:social].gsub(/(?=\d{5})\d/,"*")
  end

  private

  def default_values
    self.status ||= User.statuses[:inactive]
  end

  def guarantee_password
    self.password ||= SecureRandom.hex(4)
  end

  def adjust_phone
    self.phone = phone.scan(/\d/).join('')
  end

end
