class AddFollowUpPositionToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :follow_up_position, :integer
  end
end
