class Platform < ApplicationRecord
  # Enums
  enum category: {
    console: 0,
    arcade: 1,
    platform: 2,
    operating_system: 3,
    portable_console: 4,
    computer: 5
  }

  # Associations
  has_and_belongs_to_many :games

  # Validations
  validates :name, uniqueness: true, presence: true
  validates :category, presence: true
end
