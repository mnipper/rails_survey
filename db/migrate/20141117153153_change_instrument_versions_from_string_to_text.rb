class ChangeInstrumentVersionsFromStringToText < ActiveRecord::Migration
  def up
    change_column :device_sync_entries, :instrument_versions, :text, limit: nil
  end

  def down
    change_column :device_sync_entries, :instrument_versions, :string
  end
end
