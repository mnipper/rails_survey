class AddQuestionVersionToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :question_version, :integer, default: -1
  end
end
