class AddAboutFieldToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :about, :text
  end
end
