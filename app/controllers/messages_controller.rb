class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :authenticate_user!

  def index
    @messages = @conversation.messages
    partner_id = @conversation.recipient_id == current_user.id ? @conversation.sender_id : @conversation.recipient_id
    @partner = User.find(partner_id).name
    @conversations = Conversation.all

    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last &&  @messages.last.user_id != current_user.id
      @messages.last.read = true;
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
