class AddPassbookFieldsToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :name, :string
    add_column :merchants, :reward_program_name, :string
    add_column :merchants, :earn_type, :string
    add_column :merchants, :reward_threshold_number, :integer
    add_column :merchants, :reward_descripton, :string
  end
end
