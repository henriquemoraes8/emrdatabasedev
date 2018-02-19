class Address < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :clinic, :optional => true
  belongs_to :insurance, :optional => true
end
