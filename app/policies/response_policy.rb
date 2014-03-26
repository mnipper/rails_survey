class ResponsePolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin? || @user.manager? || @user.analyst?
  end
  
end