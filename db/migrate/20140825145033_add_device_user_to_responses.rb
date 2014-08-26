class AddDeviceUserToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :device_user_id, :integer
  end
end
