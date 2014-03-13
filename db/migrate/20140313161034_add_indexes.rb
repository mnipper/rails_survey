class AddIndexes < ActiveRecord::Migration
  def change
    add_index :devices, :identifier, name: 'index_devices_on_identifier', unique: true
    add_index :questions, :question_identifier, name: 'index_questions_on_question_identifier', unique: true
  end
end
