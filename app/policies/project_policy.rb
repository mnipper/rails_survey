class ProjectPolicy 
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    primary_project_users
  end
  
  def create?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def show?
    primary_project_users
  end

  def edit?
    primary_project_users
  end

  def update?
    primary_project_users
  end
  
  private
  def primary_project_users
    @user.admin? || @user.project_manager? || @user.user? 
  end

end