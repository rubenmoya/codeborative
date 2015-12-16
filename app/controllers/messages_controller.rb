class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id

    if @message.save
      Pusher.trigger("messages-channel", "update-chat-#{@message.get_recipient_id}", @message.as_json)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
