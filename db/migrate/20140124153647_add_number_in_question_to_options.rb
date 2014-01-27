class AddNumberInQuestionToOptions < ActiveRecord::Migration
  def change
    add_column :options, :number_in_question, :integer
  end
end
