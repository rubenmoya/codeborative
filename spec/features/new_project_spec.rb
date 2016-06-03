require "rails_helper"
require_relative "../support/omniauth"

RSpec.feature "Creating projects" do
  context "user is logged in" do
    scenario "successfully creates the project" do
      log_in_github

      click_link "Projects"
      click_link "New project"

      fill_in "Name", with: "Codeborative"
      fill_in "Url", with: "http://github.com/rubenmoya/codeborative"
      fill_in "Description", with: "This is my project at Ironhack"

      click_button "Submit"

      expect(page).to have_content("Project has been created successfully.")
    end

    scenario "fails to create a project" do
      log_in_github

      click_link "Projects"
      click_link "New project"

      fill_in "Name", with: ""
      fill_in "Url", with: ""
      fill_in "Description", with: ""

      click_button "Submit"

      expect(page).to have_content("3 Errors prevented this project from being saved:")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Url can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end

  scenario "user is not logged in" do
    visit "/projects/new"
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
