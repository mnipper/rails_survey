class ProjectWideResponsesExportWorker
  include Sidekiq::Worker
  
  def perform(project_id, csv_file, export_id)
    project = Project.find project_id
    project.surveys.to_csv(csv_file, export_id)
  end
   
end