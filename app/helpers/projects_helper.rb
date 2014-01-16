module ProjectsHelper

  def set_current_project(project)
    self.current_project = project
  end

  #TODO Incorporate current_user!!!
  def current_project
    @current_project = if session[:project_id]
      Project.find(session[:project_id])
    else
      Project.first
    end
  end

  def current_project=(project)
    session[:project_id] = project.id
  end

end
