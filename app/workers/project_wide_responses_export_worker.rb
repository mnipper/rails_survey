class ProjectWideResponsesExportWorker
  include Sidekiq::Worker
  
  def perform(project_id, csv_file)
    project = Project.find project_id
    project.surveys.to_csv(csv_file)
  end
   
end