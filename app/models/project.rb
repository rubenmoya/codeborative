class Project < ActiveRecord::Base
  belongs_to :user
  has_many :projecttags
  has_many :tags, through: :projecttags

  attr_accessor :tags_list
  before_validation :update_tags

  def self.with_tags tag_names
    Project.joins(:tags).where('LOWER(tags.text) IN (?)', tag_names).uniq
  end

  private

  def update_tags
    tags_ids = self.tags_list.split(',').map(&:to_i)
    db_tag_ids = self.tags.map(&:id)

    old_tag_ids = db_tag_ids - tags_ids
    new_tag_ids = tags_ids - db_tag_ids

    tags_to_delete = self.tags.where(id: old_tag_ids)

    tags_to_delete.each do |tag|
      self.tags.delete(tag)
    end

    new_tag_ids.each do |tag_id|
      self.tags.push(Tag.find_by_id(tag_id))
    end

    true
  end
end
