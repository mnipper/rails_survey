class ResponseImagePolicy < ResponsePolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show
    @user.admin? || @user.manager? || @user.analyst? || @user.user?
  end
  
end