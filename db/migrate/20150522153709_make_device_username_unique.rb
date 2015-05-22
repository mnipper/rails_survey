class MakeDeviceUsernameUnique < ActiveRecord::Migration
  def change
    change_column :device_users, :username, :string, :null => false, :unique => true
  end
end
