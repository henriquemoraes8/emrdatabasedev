class User < ApplicationRecord
  has_many :share_requests, :dependent => :destroy
  has_many :records, :dependent => :destroy
  has_one :address, :dependent => :destroy
  belongs_to :insurance, :optional => true

  enum status: [:inactive, :active]

  def create

  end

  def login

  end

  def records

  end

  def records_by_clinic

  end

  def validate

  end

end
