class SurveyPolicy 
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    read_access
  end

  def destroy?
    write_access
  end

  def show?
    @user.admin? || @user.manager? || @user.analyst?
  end
  
  private
  def read_access
    @user.admin? || @user.manager? || @user.user? || @user.analyst?
  end
  
  def write_access
    @user.admin?
  end

end