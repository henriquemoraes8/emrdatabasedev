class Insurance < ApplicationRecord
  has_one :address, :dependent => :destroy
  has_many :users
end
