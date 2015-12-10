class User < ActiveRecord::Base
  has_many :projects
  has_many :notifications, foreign_key: :recipient_id

  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendships: { approved: true}) }, through: :friendships, source: :friend
  has_many :passive_friends, -> { where(friendships: { approved: true}) }, through: :passive_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, through: :passive_friendships, source: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  def friends
    active_friends | passive_friends
  end

  def are_friends user_id
    self.active_friends.where('user_id = ?  || friend_id = ?', user_id, user_id)
  end

  def last_conversation
    last_conversation = Message.where(user_id: self.id).order('created_at').last

    last_conversation ? last_conversation.conversation_id : nil
  end

  def has_conversation user_id
    Conversation.between(self.id, user_id).present?
  end

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.extra.raw_info.avatar_url
      user.github = auth.extra.raw_info.html_url
      user.location = auth.extra.raw_info.location
      user.company = auth.extra.raw_info.company
    end
  end

  def self.new_with_session params, session
   super.tap do |user|
    if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
   end
  end
end
