class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street, :street_2, :zip
  belongs_to :merchant

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def address_string
    street_address + " #{city}, #{state} #{zip}"
  end

  def street_address
    if street_2
      street + " " + street_2
    else
      street
    end
  end
end
