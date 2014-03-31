class CreateResponseImagesExports < ActiveRecord::Migration
  def change
    create_table :response_images_exports do |t|
      t.integer :response_export_id
      t.string :download_url 
      t.boolean :done, :default => false 
      t.timestamps
    end
    rename_table :exports, :response_exports 
  end
end
