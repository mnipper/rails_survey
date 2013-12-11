class AddFollowingUpQuestionIdentifierToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :following_up_question_identifier, :string
  end
end
