class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def as_json
    {
      conversation_id: self.conversation.id,
      message: {
        body: self.body,
        created_at: self.created_at,
        date: self.created_at.strftime("%d %b  %Y at %I:%M%p")
      },
      sender: {
        id: self.user_id,
        name: self.user.name,
        avatar: self.user.avatar
      }
    }
  end

  def get_recipient_id
    self.user == self.conversation.sender ? self.conversation.recipient.id : self.conversation.sender.id
  end
end
