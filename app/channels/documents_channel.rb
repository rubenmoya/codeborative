class DocumentsChannel < ApplicationCable::Channel
  def follow data
    stop_all_streams
    stream_from "document:#{data['document_id'].to_i}"
  end

  def unfollow
    stop_all_streams
  end
end
