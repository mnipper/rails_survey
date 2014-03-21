class AddIdentifiesSurveyToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :identifies_survey, :boolean, default: false
  end
end
