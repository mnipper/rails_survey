require "spec_helper"

feature "Instrument Translation", js: true do
  before :each do
    pending 'current project refactor'
    @user = create(:user)
    @project = create(:project)
    @instrument = create(:instrument, project: @project)
    @question = create(:question, instrument: @instrument)
    ApplicationController.any_instance.stub(:current_project).and_return(@project)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/projects/#{@project.id}/instruments/#{@instrument.id}/instrument_translations"
    click_link 'New Translation'
  end

  scenario "clicking new translation shows new translation page" do
    click_button 'Create Instrument translation'
    expect(page).to have_text("Successfully created instrument translation")
  end

  scenario "editing the title changes the title" do
    fill_in 'instrument_translation_title', :with => 'New Title'
    click_button 'Create Instrument translation'
    expect(page).to have_text("New Title")
  end

  scenario "adding a translation saves" do
    find(:css, "textarea[id^='question_translations']").set("Translated Question")
    click_button 'Create Instrument translation'
    expect(page).to have_text("Translated Question")
  end
end
