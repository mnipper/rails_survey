module ProjectsHelper
  def set_current_project(project)
    self.current_project = project if current_user.projects.include? project
  end

  def current_project
    @current_project = if session[:project_id]
      current_user.projects.find(session[:project_id])
    end
  end

  def current_project=(project)
    session[:project_id] = project.id if current_user.projects.include? project
  end
  
  def set_current_project_id(previous_url)
    if previous_url and previous_url != '/' 
      split_previous_url = previous_url.split('/')
      project_id = split_previous_url[2]
      if project_id.to_i != 0
        set_current_project(Project.find project_id.to_i)
      end 
    end
  end
  
end
