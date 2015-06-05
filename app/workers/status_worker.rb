class StatusWorker
  include Sidekiq::Worker
  
  def perform(export_id, job_id, job_type)
    if Sidekiq::Status::complete? job_id
      export = ResponseExport.find(export_id)
      job_type == "long_job" ? export.update_attributes(:long_done => true) : export.update_attributes(:wide_done => true)
    else
      StatusWorker.perform_in(1.minute, export_id, job_id, job_type)
    end
  end
   
end