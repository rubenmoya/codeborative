class Skill < ActiveRecord::Base
  has_many :user_skills
  has_many :users, through: :user_skills

  def self.create_new_skills skill_list
    return [] if skill_list.empty?

    existing_skills = Skill.where(text: skill_list).load
    new_skill_names = skill_list - existing_skills.map(&:text)
    created_skills = new_skill_names.map { |text| Skill.create(text: text) }

    existing_skills.map(&:id) + created_skills.map(&:id)
  end
end
