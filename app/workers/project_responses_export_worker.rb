class ProjectResponsesExportWorker
  include Sidekiq::Worker

  def perform(project_id, csv_file, export_id, zipped_file, pictures_export_id)
    project = Project.find project_id
    project.responses.to_csv(csv_file, export_id)
    unless project.response_images.empty?
      project.response_images.to_zip(project.name, zipped_file, pictures_export_id)
    end
  end
  
end