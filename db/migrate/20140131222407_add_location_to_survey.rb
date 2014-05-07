class AddLocationToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :latitude, :string
    add_column :surveys, :longitude, :string
  end
end
