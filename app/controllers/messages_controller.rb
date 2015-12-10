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
      ActionCable.server.broadcast "conversations:#{@conversation.id}:messages", message: render(partial: 'messages/message', locals: { message: @message })
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
