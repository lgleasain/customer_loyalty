class CustomerPassbook < ActiveRecord::Base
  attr_accessible :customer_id, :merchant_id
  belongs_to :customer
  belongs_to :merchant 

  def serial_number
    "#{customer_id}-#{merchant_id}"
  end
end
