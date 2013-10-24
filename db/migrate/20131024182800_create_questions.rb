class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :question_type
      t.string :question_identifier
      t.integer :instrument_id

      t.timestamps
    end
  end
end
