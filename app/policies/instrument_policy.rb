class InstrumentPolicy 
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
  
  def export?
    export_access 
  end
  
  def export_responses?
    export_access
  end
  
  def export_pictures?
    export_access 
  end
  
  def move?
    read_access
  end
  
  def update_move?
    write_access
  end
  
  private
  def read_access
    @user.admin? || @user.manager? || @user.user? || @user.translator? || @user.analyst?
  end
  
  def write_access
    @user.admin? || @user.manager?
  end
  
  def export_access
    @user.admin? || @user.manager? || @user.analyst?
  end
end
