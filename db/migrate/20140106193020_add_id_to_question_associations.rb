class AddIdToQuestionAssociations < ActiveRecord::Migration
  def change
    add_column :question_associations, :question_id, :integer
  end
end
