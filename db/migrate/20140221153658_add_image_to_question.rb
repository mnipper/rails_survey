class AddImageToQuestion < ActiveRecord::Migration
  def change
    add_column :images, :question_id, :integer 
  end
end
