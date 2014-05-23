require "spec_helper"
require_relative '../../app/controllers/api/v1/frontend/questions_controller'
require_relative '../../app/policies/question_policy'

feature "Instrument Creation", js: true do
  before :each do
    @user = create(:user)
    @project = create(:project)
    @user_project = UserProject.create!(user_id: @user.id, project_id: @project.id)
    @instrument = build(:instrument, project: @project)
    ApplicationController.any_instance.stub(:current_project).and_return(@project)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/projects/#{@project.id}/instruments/new"
  end

  scenario "user creates an instrument" do
    fill_in 'instrument_title', :with => @instrument.title
    click_button "Create Instrument"
    expect(page).to have_text("Successfully created instrument.")
  end

  scenario "user creates a new question" do
    fill_in 'instrument_title', :with => @instrument.title
    click_button "Create Instrument"
    find('#add-question-button').click
    page.should have_css('#question_form')
  end

  scenario "user adds a new question" do
    fill_in 'instrument_title', :with => @instrument.title
    click_button "Create Instrument"
    find('#add-question-button').click
    select_from_chosen("FREE_RESPONSE",:from => "question-type")
    find('.ta-text').set('Question Text')
    within(".form-actions") do
      find('#save-question').click
    end
  end
end
