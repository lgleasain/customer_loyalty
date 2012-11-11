class FixTypoInMerchants < ActiveRecord::Migration
  def up
    remove_column :merchants, :reward_descripton
    add_column :merchants, :reward_description, :string
  end

  def down
    remove_column :merchants, :reward_description
    add_column :merchants, :reward_descripton, :string
  end
end
