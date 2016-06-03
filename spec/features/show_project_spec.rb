require "rails_helper"
require_relative "../support/omniauth"

RSpec.feature "Showing a project" do
  before do
    log_in_github
    @project = Project.create(
      name: "Codeborative Ironhack",
      url: "http://github.com/rubenmoya/codeborative",
      description: "My project at Ironhack",
      user_id: User.last.id
    )
  end

  scenario "display individual project" do
    visit "/"
    click_link "Projects"
    click_link @project.name

    expect(page).to have_content(@project.name)
    expect(page).to have_content(@project.description)

    expect(current_path).to eq(project_path(@project))
  end
end
