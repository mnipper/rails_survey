class ProjectsController < ApplicationController

  after_filter :verify_authorized,  except: [:index]
  after_filter :verify_policy_scoped, only: [:index]

  def index
    @projects = current_user.projects
    @projects = policy_scope(@projects)
  end

  def show
    @project = current_user.projects.find(params[:id])
    set_current_project @project
    authorize(@project)
  end

  def new
    @project = current_user.projects.new
  end

  def edit
    @project = current_user.projects.find(params[:id])
    authorize(@project)
  end

  def create
    @project = Project.new(project_params)
    authorize(@project)
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

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def update_associations(project)
      project.user_projects.create(:user_id => current_user.id, :project_id => project.id) &&
      user.roles.create(:user_id => current_user.id, :role_id => Role.select(:id).where(:name => 'project_manager'))
    end
end
