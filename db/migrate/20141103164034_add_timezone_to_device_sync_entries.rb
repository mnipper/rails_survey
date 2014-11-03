class AddTimezoneToDeviceSyncEntries < ActiveRecord::Migration
  def change
    add_column :device_sync_entries, :timezone, :string
  end
end
