class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street, :street_2, :zip

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
