class SearchController < ApplicationController
  def index
    @users = nil

    if params[:search]
      skills_names = params[:search][:skills].split(',').map(&:strip).map(&:downcase)
      @users = User.with_skills(skills_names)
    end
  end
end
