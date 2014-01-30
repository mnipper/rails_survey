class AddProjectIdToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :project_id, :integer
  end
end
