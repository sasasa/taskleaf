module NameValidatable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :name, length: { maximum: 30 }
    validates :name, uniqueness: true
  end
end