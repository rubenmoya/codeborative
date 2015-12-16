class Project < ActiveRecord::Base
  belongs_to :user
  has_many :projecttags
  has_many :tags, through: :projecttags

  validates_presence_of :name, :url, :description

  attr_accessor :tags_list

  after_save :update_tags

  def self.with_tags tag_names
    Project.joins(:tags).where('LOWER(tags.text) IN (?)', tag_names).uniq
  end

  def self.latest_projects number
    Project.all.order('created_at DESC').limit(number)
  end

  def my_tags
    tags.map {|tag| { id: tag.id, text: tag.text} }
  end

  private

  def update_tags
    tags_ids = self.tags_list.present? ? self.tags_list.split(',').map(&:to_i) : []
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
  end
end
