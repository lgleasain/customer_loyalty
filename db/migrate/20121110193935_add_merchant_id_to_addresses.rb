class AddMerchantIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :merchant_id, :integer
  end
end
