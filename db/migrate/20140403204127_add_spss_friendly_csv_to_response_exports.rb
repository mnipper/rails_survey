class AddSpssFriendlyCsvToResponseExports < ActiveRecord::Migration
  def change
    add_column :response_exports, :spss_friendly_csv_url, :string 
  end
end
