class MakeDeviceUserNonactiveByDefault < ActiveRecord::Migration
  def up
    change_column :device_users, :active, :boolean, :default => false
  end

  def down
    change_column :device_users, :active, :boolean, :default => nil
  end
end
