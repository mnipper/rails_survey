class CreateProjectDevices < ActiveRecord::Migration
  def change
    create_table :project_devices do |t|
      t.integer :project_id
      t.integer :device_id
      t.timestamps
    end
  end
end
