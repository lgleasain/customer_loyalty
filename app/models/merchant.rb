class Merchant < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  attr_accessible :addresses_attributes, :about, :reward_program_name,
    :reward_threshold_number, :reward_description

  validates :addresses, length: { minimum: 1 }

  delegate :email, to: :user
  delegate :name, to: :user
  delegate :phone_number, to: :user

  def user
    User.where(rolable_type: 'merchant', rolable_id: self.id).first
  end
end
