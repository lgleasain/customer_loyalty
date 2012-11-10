class Merchant < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  attr_accessible :addresses_attributes, :about

  validates :addresses, length: { minimum: 1 }

  def user
    User.where(rolable_type: 'merchant', rolable_id: self.id).first
  end
end
