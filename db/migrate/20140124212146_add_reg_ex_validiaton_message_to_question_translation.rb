class AddRegExValidiatonMessageToQuestionTranslation < ActiveRecord::Migration
  def change
    add_column :question_translations, :reg_ex_validation_message, :string
  end
end
