class CreateDeviceNotifications < ActiveRecord::Migration
  def change
    create_table :device_notifications do |t|
      t.text :time
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.text :message

      t.timestamps
    end
  end
end
