class Customer < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :customer_passbooks

  delegate :email, to: :user
  delegate :name, to: :user
  delegate :phone_number, to: :user

  def user
    User.where(rolable_type: 'customer', rolable_id: self.id).first
  end
end

