require "rails_helper"
require_relative "../support/omniauth"

RSpec.feature "Deleting a project" do
  before do
    log_in_github
    @project = Project.create(
      name: "Codeborative Ironhack proyect",
      url: "http://github.com/rubenmoya/codeborative",
      description: "My project at Ironhack",
      user_id: User.last.id
    )
  end

  scenario "User deletes a project" do
    visit "/"

    click_link "Projects"
    click_link @project.name
    click_link "Delete"

    expect(page).to have_content("Project has been deleted successfully.")
    expect(current_path).to eq(user_projects_path)
  end
end
