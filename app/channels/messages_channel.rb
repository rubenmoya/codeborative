# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "conversations:#{data['conversation_id'].to_i}:messages"
  end

  def unfollow
    stop_all_streams
  end
end
