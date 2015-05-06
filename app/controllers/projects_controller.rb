class ProjectsController < ApplicationController
  after_action :verify_authorized, :except => [:export]
  
  def index
    @projects = current_user.projects
    authorize @projects
  end

  def show
    @project = current_user.projects.find(params[:id])
    authorize @project
    set_current_project @project
  end

  def new
    @project = current_user.projects.new
    authorize @project
  end

  def edit
    @project = current_user.projects.find(params[:id])
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    if @project.save && @project.user_projects.create(:user_id => current_user.id, :project_id => @project.id)
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    authorize @project
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    authorize @project
    @project.destroy
    redirect_to projects_url
  end

  def export
    root = File.join('files', 'exports').to_s
    long_csv_file = File.new(root + "/#{Time.now.to_i}" + "_long" + ".csv", "a+")
    long_csv_file.close
    wide_csv_file = File.new(root + "/#{Time.now.to_i}" + "_wide" + ".csv", "a+")
    wide_csv_file.close
    export = ResponseExport.create(:project_id => current_project.id, :long_format_url => long_csv_file.path, :wide_format_url => wide_csv_file.path)
    ProjectLongResponsesExportWorker.perform_async(current_project.id, long_csv_file.path, export.id)
    ProjectWideResponsesExportWorker.perform_async(current_project.id, wide_csv_file.path, export.id)
    unless current_project.response_images.empty?
      zipped_file = File.new(root + "/#{Time.now.to_i}.zip", "a+")
      zipped_file.close 
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id, :download_url => zipped_file.path) 
      ProjectImagesExportWorker.perform_async(current_project.id, zipped_file.path, pictures_export.id)
    end
    redirect_to project_response_exports_path(current_project)
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

end
