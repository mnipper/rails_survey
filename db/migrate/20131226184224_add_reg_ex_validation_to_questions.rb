class AddRegExValidationToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :reg_ex_validation, :string
  end
end
