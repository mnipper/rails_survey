require "spec_helper"

feature "Navigation" do
  before :each do
    skip
    @user = create(:user)
    @project = create(:project)
    @user_project = UserProject.create!(user_id: @user.id, project_id: @project.id)
    visit '/users/sign_in'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Sign in'
    visit "/projects/#{@project.id}"
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

  scenario "device sidebar click shows devices", js: true do
    within('#sidebar') do
      click_link "Devices"
    end
    within('section.widget') do
      expect(page).to have_text("Devices")
    end
  end

  scenario "survey sidebar click shows surveys", js: true do
    within('#sidebar') do
      click_link "Survey Results"
    end
    within('section.widget') do
      expect(page).to have_text("Survey Results")
    end
  end

  scenario "notifications sidebar click shows notifications", js: true do
    within('#sidebar') do
      click_link "Notifications"
    end
    within('section.widget') do
      expect(page).to have_text("Notifications")
    end
  end
end
