class ChangeUserIdForCustomerPassbook < ActiveRecord::Migration
   def change
    rename_column :customer_passbooks, :user_id, :customer_id
  end
end
