class CreateGrids < ActiveRecord::Migration
  def change
    if table_exists?(:grids)
      drop_table :grids
    end
    create_table :grids do |t|
      t.integer :instrument_id
      t.string :question_type
      t.string :name
      t.text :option_texts

      t.timestamps
    end
    unless column_exists?(:questions, :grid_id)
      add_column :questions, :grid_id, :integer
    end
  end
end
