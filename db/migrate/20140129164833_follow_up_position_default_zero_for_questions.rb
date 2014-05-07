class FollowUpPositionDefaultZeroForQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :follow_up_position, :integer, default: 0
  end
end
