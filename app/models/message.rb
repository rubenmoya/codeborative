class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates :body, :conversation_id, :user_id, presence: true

  def as_json
    {
      conversation_id: conversation.id,
      message: {
        body: body,
        created_at: created_at,
        date: created_at.strftime("%d %b  %Y at %I:%M%p")
      },
      sender: {
        id: user_id,
        name: user.name,
        avatar: user.avatar
      }
    }
  end

  def recipient_id
    user == conversation.sender ? conversation.recipient.id : conversation.sender.id
  end
end
