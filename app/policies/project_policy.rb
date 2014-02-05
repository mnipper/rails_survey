class ProjectPolicy 

  class Scope < Struct.new(:user, :scope)
    def resolve
      #TODO check for user roles then scope
        scope
    end
  end

  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
    all_control
  end

  def destroy?
    all_control
  end

  def show?
    project_permissions
  end

  def edit?
    update?
  end

  def update?
    project_permissions
  end

  private
  def project_permissions
    true 
  end

  def all_control
    true
  end

end