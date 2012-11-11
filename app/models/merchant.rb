class Merchant < ActiveRecord::Base
  has_one :user, as: :rolable
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  attr_accessible :addresses_attributes, :about, :reward_program_name

  validates :addresses, length: { minimum: 1 }
end
