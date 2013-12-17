class RenameQuestionCountToPreviousQuestionCountInInstruments < ActiveRecord::Migration
  def change
    rename_column :instruments, :question_count, :previous_question_count
  end
end
