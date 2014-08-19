class CreateSkips < ActiveRecord::Migration
  def change
    create_table :skips do |t|
      t.integer :option_id
      t.string :question_identifier 
      t.timestamps
    end
  end
end
