class Project < ApplicationRecord
  include NameValidatable

  belongs_to :user
  has_many :tasks
end
