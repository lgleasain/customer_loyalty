class Customer < ActiveRecord::Base
  has_one :user, as: :rolable
  has_many :customer_passbooks
  has_many :merchants
end
