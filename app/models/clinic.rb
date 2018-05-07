class Clinic < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_one :address, :dependent => :destroy
  has_many :share_requests, :dependent => :destroy
  has_many :owned_records, -> {order 'created_at DESC'}, :class_name => 'Record', foreign_key: 'clinic_id'
  has_and_belongs_to_many :records, -> {order 'created_at DESC'}

  accepts_nested_attributes_for :address

  def users
    user_ids = share_requests.where(status: ShareRequest.statuses[:approved]).map {|r| r.user_id }
    User.where(id: user_ids)
  end

end
