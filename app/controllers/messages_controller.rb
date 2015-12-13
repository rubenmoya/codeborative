class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    to_send = {
      conversation_id: @conversation.id,
      message: {
        body: @message.body,
        created_at: @message.created_at,
        date: @message.created_at.strftime("%d %b  %Y at %I:%M%p")
      },
      sender: {
        id: @message.user_id,
        name: @message.user.name,
        avatar: @message.user.avatar
      },
      self_or_other: self_or_other
    }

    Pusher.trigger("messages-channel", "update-chat-#{message_recipient.id}", to_send)
  end

  private

  def message_recipient
    @message.user == @conversation.sender ? @conversation.recipient : @conversation.sender
  end

  def self_or_other
    @message.user == current_user ? "self" : "other"
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
