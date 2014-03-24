class ChangeRoleToRoleMask < ActiveRecord::Migration
  def change
    rename_column :users, :role, :roles_mask
  end
end
