class ChangeQuestionTextToText < ActiveRecord::Migration
  def up
   change_column :questions, :text, :text
   change_column :question_translations, :text, :text
  end

  def down
   change_column :questions, :text, :string
   change_column :question_translations, :text, :string
  end
end
