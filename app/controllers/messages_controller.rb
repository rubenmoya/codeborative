class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

    if params[:conversation_id]
      if @conversation.present?
        @messages = @conversation.messages
        @message = @conversation.messages.new
      else
        redirect_to user_messages_path
      end
    end
  end

  def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      # redirect_to conversation_messages_path(@conversation)
      ActionCable.server.broadcast 'messages',
        body: @message.body,
        time: @message.message_time,
        user: User.find(message_params[:user_id])

      head :ok
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by_id(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
