class User < ApplicationRecord
  has_many :share_requests, :dependent => :destroy
  has_many :records, :dependent => :destroy
  has_one :address, :dependent => :destroy
  belongs_to :insurance, :optional => true

  enum status: [:inactive, :active]


end
