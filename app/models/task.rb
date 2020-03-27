class Task < ApplicationRecord
  include NameValidatable

  validate :validate_name_not_including_comma
  # before_validation :set_nameless_name
  belongs_to :user
  belongs_to :project

  scope :recent, -> { order(created_at: :desc) } 

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end
  
  def self.ransackable_associations(auth_object = nil)
    %w[project]
  end

  private
  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
