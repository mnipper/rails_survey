class AddDeviceIdToDeviceSyncEntries < ActiveRecord::Migration
  def change
    add_column :device_sync_entries, :device_id, :integer
  end
end
