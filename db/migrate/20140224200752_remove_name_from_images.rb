class RemoveNameFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :name
  end
end
