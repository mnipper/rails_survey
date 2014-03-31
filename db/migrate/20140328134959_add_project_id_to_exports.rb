class AddProjectIdToExports < ActiveRecord::Migration
  def change
    add_column :exports, :project_id, :integer 
  end
end
