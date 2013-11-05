class ChangeDeviceIdToDeviceIdentifierInSurveys < ActiveRecord::Migration
  def change
    rename_column :surveys, :device_id, :device_identifier
  end
end
