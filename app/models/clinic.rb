class Clinic < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :address, :dependent => :destroy
  has_many :share_requests, :dependent => :destroy
  has_many :owned_records, :class_name => 'Record', foreign_key: 'clinic_id'
  has_and_belongs_to_many :records


end
