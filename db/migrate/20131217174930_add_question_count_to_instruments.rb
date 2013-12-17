class AddQuestionCountToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :question_count, :integer
  end
end
