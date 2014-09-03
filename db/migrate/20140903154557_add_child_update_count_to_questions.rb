class AddChildUpdateCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :child_update_count, :integer, default: 0
  end
end
