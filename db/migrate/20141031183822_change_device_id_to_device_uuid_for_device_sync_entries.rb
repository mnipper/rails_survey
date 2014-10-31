class ChangeDeviceIdToDeviceUuidForDeviceSyncEntries < ActiveRecord::Migration
  def change
    rename_column :device_sync_entries, :device_id, :device_uuid
    change_column :device_sync_entries, :device_uuid, :string
  end
end
