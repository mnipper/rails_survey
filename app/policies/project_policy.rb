class ProjectPolicy < ApplicationPolicy

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
    true
  end

end