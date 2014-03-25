class ChangeQuestionInstructionsDefaultValueToBlankString < ActiveRecord::Migration
  def change
    change_column_default(:questions, :instructions, "")
  end
end
