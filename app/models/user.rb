class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :share_requests, :dependent => :destroy
  has_many :records, :dependent => :destroy
  has_one :address, :dependent => :destroy
  belongs_to :insurance, :optional => true

  enum status: [:inactive, :active]

  def clinics
    result = []
    records.includes(:owner_clinic).each do |r|
      result.append(r.owner_clinic)
    end
    result.uniq
  end

end
