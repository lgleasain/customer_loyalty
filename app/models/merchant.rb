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

  def address
    self.addresses.first.address_string
  end

  def self.find_by_search_params(params)
    return Merchant.all unless search_params_present?(params)
    [
      Merchant.find_by_users_name(params[:name]),
      Merchant.find_by_city(params[:city]),
      Merchant.find_by_zip(params[:zip])
    ].flatten
  end

  def self.search_params_present?(params)
    if params
      params[:name].present? || params[:city].present? || params[:zip].present?
    else
      false
    end
  end

  def self.find_by_users_name(name)
    Merchant.all.select { |m| m.user.name.downcase == name.downcase }
  end

  def self.find_by_city(city)
    Merchant.all.select { |m| m.addresses.any? { |a| a.city.downcase == city.downcase } }
  end

  def self.find_by_zip(zip)
    Merchant.all.select { |m| m.addresses.any? { |a| a.zip.downcase == zip.downcase } }
  end
end
