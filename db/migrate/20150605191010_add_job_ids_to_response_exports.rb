class AddJobIdsToResponseExports < ActiveRecord::Migration
  def change
    add_column :response_exports, :long_job_id, :string
    add_column :response_exports, :wide_job_id, :string
    add_column :response_exports, :wide_done, :boolean, default: :false
    rename_column :response_exports, :done, :long_done 
  end
end
