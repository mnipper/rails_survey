module ProjectsHelper

  def set_current_project(project)
    self.current_project = project
  end

  def current_project
    @current_project = if session[:project_id]
      current_user.projects.find(session[:project_id])
    end
  end

  def current_project=(project)
    session[:project_id] = project.id
  end

end
