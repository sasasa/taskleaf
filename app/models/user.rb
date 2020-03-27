class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks
  has_many :projects

  has_many :skills_users, dependent: :destroy
  has_many :skills, through: :skills_users

  def init_skill_ids
    skill_ids
  end

  def setProficiency!(skills_user_params)
    ActiveRecord::Base.transaction do
      skills_user_params.each do |id, val|
        skills_user = self.skills_users.find(id)
        skills_user.proficiency = val[:proficiency]
        skills_user.save!
      end 
    end
  end

  def projects_option_for_select
    projects.map{|p|[p.name, p.id]}
  end
end
