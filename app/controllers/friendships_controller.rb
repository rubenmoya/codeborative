class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save

      #create Notification

      Notification.create(recipient: User.find(params[:friend_id].to_i), actor: current_user, action: "sended", notifiable: @friendship)


      redirect_to :back, flash: {success: "Friend request sent." }
    else
      redirect_to :back, flash: {success: "Unable to request friendship." }
    end
  end

  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(approved: true)

    if @friendship.save
      redirect_to root_url, flash: {success: "Friend request accepted." }
    else
      redirect_to root_url, flash: {success: "Couldn't confirm the friend request." }
    end
  end

  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy

    redirect_to :back, flash: {success: "Friendship removed successfully." }
  end
end
