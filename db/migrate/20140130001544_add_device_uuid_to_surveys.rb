class AddDeviceUuidToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :device_uuid, :string
  end
end
