class Customer < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :customer_passbooks
  has_many :merchants
end
