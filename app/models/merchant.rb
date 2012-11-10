class Merchant < ActiveRecord::Base
  has_one :user, as: :rolable
  has_many :addresses
end
