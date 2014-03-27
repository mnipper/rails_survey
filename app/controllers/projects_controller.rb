class ProjectsController < ApplicationController
  after_action :verify_authorized, :except => [:export, :export_pictures]
  
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
    respond_to do |format|
      format.csv { render text: current_project.responses.to_csv }
    end
  end
  
  def export_pictures
    zipped_pictures = current_project.response_images.to_zip(current_project.name)
    send_file zipped_pictures.path, :type => 'application/zip', :disposition => 'attachment', :filename => "#{current_project.name}" 
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

end
