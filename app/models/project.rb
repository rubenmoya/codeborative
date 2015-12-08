class Project < ActiveRecord::Base
  belongs_to :user
  has_many :projecttags
  has_many :tags, through: :projecttags

  def self.with_tags tag_names
    Project.joins(:tags).where('LOWER(tags.text) IN (?)', tag_names).uniq
  end
end
