class AddInstructionsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :instructions, :text
  end
end
