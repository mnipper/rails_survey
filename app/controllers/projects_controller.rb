class ProjectsController < ApplicationController

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
    set_current_project @project
  end

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
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
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to projects_url
  end

  def export
    respond_to do |format|
      format.csv { render text: current_project.responses.to_csv }
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
