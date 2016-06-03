class Tag < ActiveRecord::Base
  has_many :projecttags
  has_many :projects, through: :projecttags

  validates :text, presence: true
end
