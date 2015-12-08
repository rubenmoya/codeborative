class Tag < ActiveRecord::Base
  has_many :projecttags
  has_many :projects, through: :projecttags
end
