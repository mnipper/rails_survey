class AddUserIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :user_id, :integer 
  end
end
