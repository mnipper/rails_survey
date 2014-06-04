require "spec_helper"

feature "Security" do
  before :all do
    @user = create(:user)
  end

  scenario "user enters an incorrect password 10 times", js: true do
    visit '/users/sign_in'
    10.times do
      fill_in 'user_email', :with => @user.email 
      fill_in 'user_password', :with => 'wr0ngp4$$w0rd'
      click_button 'Sign in'
    end
    expect(page).to have_text("Your account is locked")
  end
end
