class CreateQuestionAssociations < ActiveRecord::Migration
  def change
    create_table :question_associations do |t|
      t.integer :instrument_version
      t.integer :question_version
      t.timestamps
    end
  end
end
