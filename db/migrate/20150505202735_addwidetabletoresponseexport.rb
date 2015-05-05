class Addwidetabletoresponseexport < ActiveRecord::Migration
  def change
    add_column :response_exports, :wide_format_url, :string
    rename_column :response_exports, :download_url, :long_format_url
  end
end
