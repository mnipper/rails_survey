class CreateInstrumentTranslations < ActiveRecord::Migration
  def change
    create_table :instrument_translations do |t|
      t.integer :instrument_id
      t.string :language
      t.string :alignment
      t.string :title

      t.timestamps
    end
  end
end
