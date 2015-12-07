class SkillsController < ApplicationController
  def index
    @skills = Skill.all

    render json: @skills
  end

  def create
    @skill = Skill.create(text: params[:text])

    render json: @skill
  end
end
