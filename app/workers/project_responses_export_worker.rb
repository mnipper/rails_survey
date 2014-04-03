class ProjectResponsesExportWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find project_id
    export = ResponseExport.create(:project_id => project_id)
    csv_file = project.responses.to_csv
    spss_csv_file = project.responses.to_spss_friendly_csv
    spss_syntax_file = project.responses.spss_label_values
    export.update(:download_url => csv_file.path, :done => true)
    export.update(:spss_friendly_csv_url => spss_csv_file.path)
    export.update(:spss_syntax_file_url => spss_syntax_file.path)
    unless project.response_images.empty?
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id)
      zip_file = project.response_images.to_zip(project.name)
      pictures_export.update(:download_url => zip_file.path, :done => true)
    end
  end
  
end