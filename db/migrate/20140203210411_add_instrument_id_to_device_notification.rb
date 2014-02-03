class AddInstrumentIdToDeviceNotification < ActiveRecord::Migration
  def change
    add_column :device_notifications, :instrument_id, :integer
  end
end
