require "rails_helper"

RSpec.describe Project do
  it "is invalid without name" do
    project = Project.create(name: "",
                             url: "http://github.com/rubenmoya/codeborative",
                             description: "My project at Ironhack",
                             user_id: 1)

    expect(project).to_not be_valid
  end

  it "is invalid without url" do
    project = Project.create(name: "Codeborative",
                             url: "",
                             description: "My project at Ironhack",
                             user_id: 1)

    expect(project).to_not be_valid
  end

  it "is invalid without description" do
    project = Project.create(name: "Codeborative",
                             url: "http://github.com/rubenmoya/codeborative",
                             description: "",
                             user_id: 1)

    expect(project).to_not be_valid
  end

  it "is valid with all the fields" do
    project = Project.create(name: "Codeborative",
                             url: "http://github.com/rubenmoya/codeborative",
                             description: "My project at Ironhack",
                             user_id: 1)

    expect(project).to be_valid
  end
end
