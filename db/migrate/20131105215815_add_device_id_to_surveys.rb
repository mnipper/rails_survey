class AddDeviceIdToSurveys < ActiveRecord::Migration
  def change
    remove_column :surveys, :device_identifier
    add_column :surveys, :device_id, :integer
  end
end
