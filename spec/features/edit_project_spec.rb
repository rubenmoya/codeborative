require "rails_helper"
require_relative "../support/omniauth"

RSpec.feature "Editing a project" do
  before do
    log_in_github
    @project = Project.create(
      name: "Codeborative Ironhack proyect",
      url: "http://github.com/rubenmoya/codeborative",
      description: "My project at Ironhack",
      user_id: User.last.id
    )
  end

  scenario "User updates a project" do
    visit "/"

    click_link "Projects"
    click_link @project.name
    click_link "Edit"

    fill_in "Name", with: "Codehack"

    click_button "Submit"

    expect(page).to have_content("Project has been updated successfully.")
    expect(current_path).to eq(project_path(@project))
    expect(page).to have_content("Codehack")
  end

  scenario "User fails to update a project" do
    visit "/"

    click_link "Projects"
    click_link @project.name
    click_link "Edit"

    fill_in "Name", with: ""

    click_button "Submit"

    expect(page).to have_content("1 Error prevented this project from being saved:")
    expect(page).to have_content("Name can't be blank")
  end
end
