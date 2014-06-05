require "spec_helper"

describe AdminUser do
  before :each do
    @admin_user = build(:admin_user)
  end

  describe "complex password" do
    it "should not allow a password with no digits" do
      @admin_user.password = @admin_user.password_confirmation = "Password"
      @admin_user.should_not be_valid
    end

    it "should not allow a password with no upper case letters" do
      @admin_user.password = @admin_user.password_confirmation = "password1"
      @admin_user.should_not be_valid
    end

    it "should not allow a password with no lower case letters" do
      @admin_user.password = @admin_user.password_confirmation = "PASSWORD1"
      @admin_user.should_not be_valid
    end

    it "should allow a password with lower case letters, upper case letters, and a digit" do
      @admin_user.password = @admin_user.password_confirmation = "Password1"
      @admin_user.should be_valid
    end
  end
end
