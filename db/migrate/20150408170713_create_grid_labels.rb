class CreateGridLabels < ActiveRecord::Migration
  def change
    create_table :grid_labels do |t|
      t.text :label
      t.integer :grid_id
      t.integer :option_id

      t.timestamps
    end
    unless column_exists?(:questions, :first_in_grid)
      add_column :questions, :first_in_grid, :boolean, :default => false
    end
    remove_column :grids, :option_texts
  end
end
