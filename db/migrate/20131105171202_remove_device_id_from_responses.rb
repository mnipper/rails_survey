class RemoveDeviceIdFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :device_id
  end
end
