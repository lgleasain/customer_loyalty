class AddDefaultValueToCustomerPassbook < ActiveRecord::Migration
   def change
    change_column :customer_passbooks, :balance, :integer, :default => 0
  end
end
