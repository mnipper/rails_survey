class DevicePolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin? || @user.manager? || @user.user?
  end
  
end