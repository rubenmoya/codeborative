class ConversationsController < ApplicationController
  before_action :authenticate_user!
  layout false

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create! conversation_params
    end

    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new

    @messages = @conversation.messages
    @reciever = interlocutor @conversation
  end

  private

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
