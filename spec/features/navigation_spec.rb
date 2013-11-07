require "spec_helper"

feature "Navigation" do
  before :each do
    @user = FactoryGirl.build(:user)
    @user.save!
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
  end

  scenario "user collapses instruments sidebar", js: true do
    within('#sidebar') do
      click_link "Instruments"
      within('ul#instruments-collapse') do
        expect(page).to have_text("View Instruments")
        expect(page).to have_text("New Instrument")
      end
    end
  end
end
