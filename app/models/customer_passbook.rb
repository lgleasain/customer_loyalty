class CustomerPassbook < ActiveRecord::Base
  attr_accessible :customer_id, :merchant_id, :balance
  belongs_to :customer
  belongs_to :merchant 

  def serial_number
    "#{customer_id}-#{merchant_id}"
  end
end
