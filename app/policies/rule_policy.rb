class RulePolicy 
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    read_access
  end
  
  def new?
    write_access
  end
  
  def create?
    write_access
  end

  def destroy?
    write_access
  end

  def show?
    read_access
  end

  def edit?
    write_access
  end

  def update?
    write_access
  end
  
  private
  def read_access
    @user.admin? || @user.manager? || @user.user? || @user.translator? || @user.analyst?
  end
  
  def write_access
    @user.admin? || @user.manager?
  end
end
