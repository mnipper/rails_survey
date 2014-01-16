class RemoveProjectIdFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :project_id
  end
end
