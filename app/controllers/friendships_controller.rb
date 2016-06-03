class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      redirect_to :back, flash: { success: "Friend request sent." }
    else
      redirect_to :back, flash: { error: "Unable to request friendship, try again." }
    end
  end

  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first

    if @friendship.update(approved: true)
      redirect_to root_url, flash: { success: "Friend request accepted." }
    else
      redirect_to root_url, flash: { error: "Couldn't confirm the friend request." }
    end
  end

  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]])
                            .where(user_id: [current_user, params[:id]]).last
    @friendship.destroy

    redirect_to :back, flash: { success: "Friendship removed successfully." }
  end
end
