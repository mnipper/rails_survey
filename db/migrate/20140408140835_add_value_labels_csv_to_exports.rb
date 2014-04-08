class AddValueLabelsCsvToExports < ActiveRecord::Migration
  def change
    add_column :response_exports, :value_labels_csv, :string 
  end
end
