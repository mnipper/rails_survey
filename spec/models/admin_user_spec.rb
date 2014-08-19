# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  gauth_secret           :string(255)
#  gauth_enabled          :string(255)      default("f")
#  gauth_tmp              :string(255)
#  gauth_tmp_datetime     :datetime
#

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
