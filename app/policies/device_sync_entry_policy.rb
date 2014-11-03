class DeviceSyncEntryPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin? || @user.manager?
  end
end
