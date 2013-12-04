require "spec_helper"

feature "Instrument Versions", js: true, versioning: true do
  before :each do
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    @instrument = FactoryGirl.create(:instrument)
    visit "/instruments/#{@instrument.id}"
  end

  scenario "to list past versions" do
    old_title = @instrument.title
    @instrument.update_attributes!(title: 'New Name')
    click_link "Past Versions"
    within('table.table') do
      expect(page).to have_text("0")
      expect(page).to have_text(old_title)
      expect(page).to have_text(@user.email)
    end
  end
end
