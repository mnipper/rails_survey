# class ProjectPolicy < ApplicationPolicy
  # attr_reader :user, :project
  # class Scope < Struct.new(:user, :scope)
    # def resolve
      # scope
    # end
  # end
# 
  # def initialize(user, project)
    # @user = user
    # @project = project
  # end
# 
  # def create?
    # write_permissions
  # end
# 
  # def destroy?
    # write_permissions
  # end
# 
  # def show?
    # read_permissions
  # end
# 
  # def edit?
    # update?
  # end
# 
  # def update?
    # write_permissions
  # end
# 
  # private
  # def write_permissions
    # if current_admin_user or current_user.project_manager
      # true
    # end 
  # end
#   
  # def read_permissions
    # true 
  # end
# 
# end