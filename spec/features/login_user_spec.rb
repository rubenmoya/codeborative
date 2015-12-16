require "rails_helper"
require_relative "../support/omniauth"

RSpec.feature "Users login" do
  scenario "with valid credentials" do
    log_in_github()

    expect(page).to have_content("Successfully logged in.")
  end

  scenario "with invalid credentials" do
    set_invalid_omniauth()

    visit "/"
    click_link "Connect with Github"

    expect(page).to have_content("Couldn't sign in, try again later.")
  end
end
