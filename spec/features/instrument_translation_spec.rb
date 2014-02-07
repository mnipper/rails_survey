require "spec_helper"

feature "Instrument Translation", js: true do
  before :each do
    @user = create(:user)
    @question = create(:question)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/projects/#{@question.instrument.project.id}/instruments/#{@question.instrument.id}/instrument_translations"
  end

  scenario "clicking new translation shows new translation page" do
    click_link 'New Translation'
    click_button 'Create Instrument translation'
    expect(page).to have_text("Successfully created instrument translation")
  end

  scenario "editing the title changes the title" do
    click_link 'New Translation'
    fill_in 'instrument_translation_title', :with => 'New Title'
    click_button 'Create Instrument translation'
    expect(page).to have_text("New Title")
  end

  scenario "adding a translation saves" do
    click_link 'New Translation'
    find(:css, "textarea[id^='question_translations']").set("Translated Question")
    click_button 'Create Instrument translation'
    expect(page).to have_text("Translated Question")
  end
end
