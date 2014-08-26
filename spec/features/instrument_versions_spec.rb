require "spec_helper"

feature "Instrument Versions", js: true, versioning: true do
  before :each do
    skip
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    ApplicationController.any_instance.stub(:current_project).and_return(@project)
    @user_project = UserProject.create!(user_id: @user.id, project_id: @project.id)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    @instrument = FactoryGirl.create(:instrument, project: @project)
    @old_title = @instrument.title
    @instrument.update_attributes!(title: 'New Name')
    visit "/projects/#{@instrument.project.id}/instruments/#{@instrument.id}/versions"
  end

  scenario "to list past versions" do
    within('section.widget') do
      expect(page).to have_text("0")
      expect(page).to have_text(@old_title)
      expect(page).to have_text(@user.email)
    end
  end
end
