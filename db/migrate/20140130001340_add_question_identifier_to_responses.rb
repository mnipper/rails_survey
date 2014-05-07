class AddQuestionIdentifierToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :question_identifier, :string
  end
end
