class CreateDeviceUsers < ActiveRecord::Migration
  def change
    create_table :device_users do |t|
      t.string :username
      t.string :name
      t.string :password_digest
      t.boolean :active
      t.integer :device_id

      t.timestamps
    end
  end
end
