class CreateDeviceSyncEntries < ActiveRecord::Migration
  def change
    create_table :device_sync_entries do |t|
      t.string :latitude
      t.string :longitude
      t.integer :num_surveys
      t.string :current_language
      t.string :current_version
      t.string :instrument_versions

      t.timestamps
    end
  end
end
