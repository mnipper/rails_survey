class AddCompletionRateToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :completion_rate, :decimal
  end
end
