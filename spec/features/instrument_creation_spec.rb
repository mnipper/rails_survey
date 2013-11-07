require "spec_helper"

feature "Instrument Creation" do
  before :each do
    @user = FactoryGirl.build(:user)
    @user.save!
  end

  scenario "User adds a new question", js: true do
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/instruments/new"
    click_link "Add Question"
    expect(page).to have_text("Question type")
  end
end
