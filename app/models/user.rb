class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks
  has_many :projects

  has_many :skills_users
  has_many :skills, through: :skills_users

  def init_skill_ids
    skill_ids
  end
end
