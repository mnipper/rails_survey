class CreateOptionTranslations < ActiveRecord::Migration
  def change
    create_table :option_translations do |t|
      t.integer :option_id
      t.string :text
      t.string :language

      t.timestamps
    end
  end
end
