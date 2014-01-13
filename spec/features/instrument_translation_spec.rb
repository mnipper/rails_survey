require "spec_helper"

feature "Instrument Translation", js: true do
  before :each do
    pending "angular refactor"
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/instruments/new"
    fill_in 'instrument_title', :with => "Test Instrument"
    click_link "Add Question"
    first(:css, "input[id$='_question_identifier']").set("qid")
    find(:css, "textarea[id$='text']").set("Question text")
    click_button "Create Instrument"
    click_link "Translations"
  end

  scenario "clicking new translation shows new translation page" do
    click_link "New Translation"
    click_button 'Create Instrument translation'
    expect(page).to have_text("Successfully created instrument translation")
  end

  scenario "editing the title changes the title" do
    click_link "New Translation"
    fill_in 'instrument_translation_title', :with => 'New Title'
    click_button 'Create Instrument translation'
    expect(page).to have_text("New Title")
  end

  scenario "adding a translation saves" do
    click_link "New Translation"
    find(:css, "textarea[id^='question_translations']").set("Translated Question")
    click_button 'Create Instrument translation'
    expect(page).to have_text("Translated Question")
  end
end
