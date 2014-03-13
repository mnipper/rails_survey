class ChangeQuestionTextToText < ActiveRecord::Migration
  def up
   change_column :questions, :text, :text, limit: nil
   change_column :question_translations, :text, :text, limit: nil
  end

  def down
   change_column :questions, :text, :string
   change_column :question_translations, :text, :string
  end
end
