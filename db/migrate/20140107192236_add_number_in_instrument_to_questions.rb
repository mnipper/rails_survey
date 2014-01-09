class AddNumberInInstrumentToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :number_in_instrument, :integer
  end
end
