class Document < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id, class_name: 'User'
  belongs_to :friend, foreign_key: :friend_id, class_name: 'User'

  validates_uniqueness_of :user_id, :scope => :friend_id

  scope :between, -> (user_id, friend_id) do
    where("(documents.user_id = ? AND documents.friend_id =?) OR (documents.user_id = ? AND documents.friend_id =?)", user_id, friend_id, friend_id, user_id)
  end
end
