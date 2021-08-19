class Critic < ApplicationRecord
  # Associations
  belongs_to :user, counter_cache: true
  belongs_to :criticable, polymorphic: true

  # Validations
  validates :title, presence: true, length: { maximum: 40 }
  validates :body, presence: true
end
