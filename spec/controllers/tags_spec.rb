require 'rails_helper'

RSpec.describe ProjectsController, :type => :request do
  before do
    mock_auth_hash()
    get '/auth/github'
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    get '/auth/github/callback'
  end

  describe "GET #index" do
    before do
      @tag = Tag.create(text: "Ruby on Rails")
    end

    it "return tags as json" do
      get tags_path
      expect(assigns(:tags)).to eq([@tag])
    end
  end

  describe "POST #create" do
    it "creates a tag with valid attributes" do
      expect {
        post tags_new_path, {
          text: "Ruby on Rails"
        }
      }.to change(Tag, :count).by(1)
    end

    it "does not create a tag with invalid attributes" do
      expect {
        post tags_new_path, {
          text: ""
        }
      }.to_not change(Tag, :count)
    end
  end
end
