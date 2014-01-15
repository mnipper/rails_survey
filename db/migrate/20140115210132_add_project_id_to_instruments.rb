class AddProjectIdToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :project_id, :integer
  end
end
