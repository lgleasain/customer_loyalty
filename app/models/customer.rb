class Customer < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :customer_passbooks
  has_many :merchants

  def user
    User.where(rolable_type: 'customer', rolable_id: self.id).first
  end
end

