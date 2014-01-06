class RenameQuestionAssociationsToQuestionAssociation < ActiveRecord::Migration
  def change
    rename_table :question_associations, :question_association
  end
end
