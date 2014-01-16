class AddProjectIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :project_id, :integer
  end
end
