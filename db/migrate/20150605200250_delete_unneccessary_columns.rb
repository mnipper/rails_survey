class DeleteUnneccessaryColumns < ActiveRecord::Migration
  def change
    remove_column :response_exports, :long_job_id
    remove_column :response_exports, :wide_job_id
  end
end
