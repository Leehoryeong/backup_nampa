class AddUserIdToUserSpec < ActiveRecord::Migration[5.0]
  def change
    add_column :user_specs, :user_id, :integer
    add_index :user_specs, :user_id
  end
end
