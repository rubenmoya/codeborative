module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  def message_interlocutor(message)
    return message.conversation.sender if message.user == message.conversation.sender
    message.conversation.recipient
  end
end
