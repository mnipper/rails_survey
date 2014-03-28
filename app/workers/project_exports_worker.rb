class ProjectExportsWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find project_id
    export = Export.create(:project_id => project_id)
    csv_file = project.responses.to_csv
    export.update(:download_url => csv_file.path, :done => true)
  end
  
end