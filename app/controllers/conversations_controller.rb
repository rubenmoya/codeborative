class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
      redirect_to user_messages_path(@conversation.id)
    else
      @conversation = Conversation.create!(conversation_params)
      redirect_to user_messages_path(@conversation.id)
    end
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
