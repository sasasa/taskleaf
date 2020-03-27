class Project < ApplicationRecord
  include NameValidatable

  belongs_to :user
  has_many :tasks
  accepts_nested_attributes_for :tasks

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
