class AddRolablePlymorphicFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :rolable_id, :integer
    add_column :users, :rolable_type, :string
    add_index :users, [ :rolable_id, :rolable_type ], name: 'user_role_index'
  end
end
