class RemoveUserRolesModel < ActiveRecord::Migration
  def change
    drop_table :roles
    add_column :users, :role, :integer
  end
end
