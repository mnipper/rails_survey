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
    @project = Project.new(params[:project])
    if @project.save && @project.user_projects.create(:user_id => current_user.id, :project_id => @project.id)
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    authorize @project
    if @project.update(params[:project])
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
    csv_file = File.new(root + "/#{Time.now.to_i}.csv", "a+")
    csv_file.close
    export = ResponseExport.create(:project_id => current_project.id, :download_url => csv_file.path)
    if current_project.response_images.empty?
      ProjectResponsesExportWorker.perform_async(current_project.id, csv_file.path, export.id, nil, nil)
    else
      zipped_file = File.new(root + "/#{Time.now.to_i}.zip", "a+")
      zipped_file.close 
      pictures_export = ResponseImagesExport.create(:response_export_id => export.id, :download_url => zipped_file.path) 
      ProjectResponsesExportWorker.perform_async(current_project.id, csv_file.path, export.id, zipped_file.path, pictures_export.id)
    end
    redirect_to project_response_exports_path(current_project)
  end
end
