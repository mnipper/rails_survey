class AddApiKeyToDeviceSyncEntires < ActiveRecord::Migration
  def change
    add_column :device_sync_entries, :api_key, :string
  end
end
