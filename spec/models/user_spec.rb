require "spec_helper"

describe User do
  before :each do
    @user = build(:user)
  end

  describe "complex password" do
    it "should not allow a password with no digits" do
      @user.password = @user.password_confirmation = "Password"
      @user.should_not be_valid
    end

    it "should not allow a password with no upper case letters" do
      @user.password = @user.password_confirmation = "password1"
      @user.should_not be_valid
    end

    it "should not allow a password with no lower case letters" do
      @user.password = @user.password_confirmation = "PASSWORD1"
      @user.should_not be_valid
    end

    it "should allow a password with lower case letters, upper case letters, and a digit" do
      @user.password = @user.password_confirmation = "Password1"
      @user.should be_valid
    end
  end
end
