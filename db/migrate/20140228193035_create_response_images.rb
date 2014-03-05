class CreateResponseImages < ActiveRecord::Migration
  def change
    create_table :response_images do |t|
      t.string :response_uuid
      t.timestamps
    end
  end
end
