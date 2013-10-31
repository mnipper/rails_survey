class AddNextQuestionToOptions < ActiveRecord::Migration
  def change
    add_column :options, :next_question, :string
  end
end
