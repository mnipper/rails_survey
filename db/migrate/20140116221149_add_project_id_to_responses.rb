class AddProjectIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :project_id, :integer
  end
end
