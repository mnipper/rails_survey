class RemoveProjectIdFromSurveys < ActiveRecord::Migration
  def change
    remove_column :surveys, :project_id
  end
end
