class CreateExports < ActiveRecord::Migration
  def change
    create_table :exports do |t|
      t.string :download_url 
      t.boolean :done, :default => false 
      t.timestamps
    end
  end
end
