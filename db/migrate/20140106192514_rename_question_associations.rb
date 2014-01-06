class RenameQuestionAssociations < ActiveRecord::Migration
  def change
    rename_table :question_association, :question_associations
  end
end
