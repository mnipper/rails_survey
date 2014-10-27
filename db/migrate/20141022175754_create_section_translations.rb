class CreateSectionTranslations < ActiveRecord::Migration
  def change
    create_table :section_translations do |t|
      t.integer :section_id
      t.string :language
      t.string :text

      t.timestamps
    end
  end
end
