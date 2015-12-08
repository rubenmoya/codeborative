class User < ActiveRecord::Base
  has_many :user_skills
  has_many :skills, through: :user_skills

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
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

  def self.with_skills skill_names
    User.joins(:skills).where('LOWER(skills.text) IN (?)', skill_names).uniq
  end

  def get_skills
    self.skills.map(&:text).join(',')
  end
end
