class Skill < ApplicationRecord
  include NameValidatable
  
  has_many :skills_users
  has_many :users, through: :skills_users


  CATEGORY = {
    0 => "オフィス",
    1 => "プログラム",
    2 => "デザイン",
  }

  def category_name
    CATEGORY[self.category]
  end

  def self.category_options_for_select
    CATEGORY.invert
  end

  def self.skill_ids
    result = {}
    self.all.each do |skill|
      result[skill.category_name] = [] unless result[skill.category_name]
      result[skill.category_name] << [skill.name, skill.id]
    end
    result
  end

  def name_and_proficiency(user)
    name + "(#{self.skills_users.find_by(user_id: user.id).proficiency})"
  end
end
