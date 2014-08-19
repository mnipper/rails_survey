class AddProjectIdToDeviceUsers < ActiveRecord::Migration
  def change
    add_column :device_users, :project_id, :integer
  end
end
