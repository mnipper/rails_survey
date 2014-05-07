class AddDeletedAtToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :deleted_at, :datetime
  end
end
