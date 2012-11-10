class CreateCustomerPassbook < ActiveRecord::Migration
  def change
    create_table :customer_passbooks do |t|
      t.integer :merchant_id
      t.integer :user_id
      t.integer :balance
      t.timestamps
    end
  end

end
