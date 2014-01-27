class AddRegExValidationMessageToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :reg_ex_validation_message, :string
  end
end
