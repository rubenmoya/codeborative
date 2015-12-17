require 'rails_helper'

RSpec.describe Tag do
  it "is valid with a text" do
    tag = Tag.new(text: "Ruby on Rails")

    expect(tag).to be_valid
  end

  it "is invalid without text" do
    tag = Tag.new(text: "")

    expect(tag).to_not be_valid
  end
end
