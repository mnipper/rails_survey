class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
    project_permissions
  end

  def destroy?
    project_permissions
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
    if user.role.name == 'project_manager'
      true
    end 
  end

end