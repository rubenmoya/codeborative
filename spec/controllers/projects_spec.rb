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
      @project = Project.create(
        name: "Codeborative Ironhack",
        url: "http://github.com/rubenmoya/codeborative",
        description: "My project at Ironhack",
        user_id: User.last.id
      )
    end

    it "populates an array of projects" do
      get projects_path
      expect(assigns(:projects)).to eq([@project])
    end

    it "renders the :index view" do
      get projects_path
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      @project = Project.create(
        name: "Codeborative Ironhack",
        url: "http://github.com/rubenmoya/codeborative",
        description: "My project at Ironhack",
        user_id: User.last.id
      )
    end

    it "assigns the requested project to @project" do
      get project_path(@project)
      expect(assigns(:project)).to eq(@project)
    end

    it "renders the :show template" do
      get project_path(@project)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Project to @project" do
      get new_project_path
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the :new template" do
      get new_project_path
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{
          post projects_path, project: {
            name: "Codeborative Ironhack",
            url: "http://github.com/rubenmoya/codeborative",
            description: "My project at Ironhack"
          }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the project page" do
        post projects_path, project: {
          name: "Codeborative Ironhack",
          url: "http://github.com/rubenmoya/codeborative",
          description: "My project at Ironhack"
        }
        expect(response).to redirect_to Project.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post projects_path, project: {
            name: "",
            url: "http://github.com/rubenmoya/codeborative",
            description: "My project at Ironhack"
          }
        }.to_not change(Project, :count)
      end
      
      it "re-renders the :new template" do
        post projects_path, project: {
          name: "",
          url: "http://github.com/rubenmoya/codeborative",
          description: "My project at Ironhack"
        }
        expect(response).to render_template :new
      end
    end
  end
end
