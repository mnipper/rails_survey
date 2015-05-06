class DeleteSpssAttributesFromResponseExports < ActiveRecord::Migration
  def change
    remove_column :response_exports, :spss_syntax_file_url, :string
    remove_column :response_exports, :spss_friendly_csv_url, :string
    remove_column :response_exports, :value_labels_csv, :string
  end
end
