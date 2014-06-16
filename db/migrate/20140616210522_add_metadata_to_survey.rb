class AddMetadataToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :metadata, :text
  end
end
