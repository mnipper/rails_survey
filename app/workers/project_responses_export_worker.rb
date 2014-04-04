class ProjectResponsesExportWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find project_id
    export = ResponseExport.create(:project_id => project_id)
    csv_file = project.responses.to_csv
    export.update(:download_url => csv_file.path, :done => true)
    unless project.response_images.empty?
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id)
      zip_file = project.response_images.to_zip(project.name)
      pictures_export.update(:download_url => zip_file.path, :done => true)
    end
  end
  
end