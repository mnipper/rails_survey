class AddIndexToResponseImages < ActiveRecord::Migration
  def change
    add_index :responses, :uuid 
  end
end
