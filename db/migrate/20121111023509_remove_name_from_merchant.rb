class RemoveNameFromMerchant < ActiveRecord::Migration
   def change
    remove_column :merchants, :name
  end
end
