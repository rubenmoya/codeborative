class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:projects, :friends]
  before_action :set_user

  def show
  end

  def projects
    @projects = Project.where(user_id: current_user.id)
  end

  def friends
    @friends = current_user.friends
    @requested_friendships = current_user.requested_friendships
    @pending_friens = current_user.pending_friends
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end
end
