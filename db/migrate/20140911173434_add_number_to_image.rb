class AddNumberToImage < ActiveRecord::Migration
  def change
    add_column :images, :number, :integer
  end
end
