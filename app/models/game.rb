class Game < ApplicationRecord
  # Enums
  enum category: { main_game: 0, expansion: 1 }

  # Associations
  has_many :companies, through: :involved_companies
  has_many :involved_companies, dependent: :destroy
  has_many :critics, as: :criticable, dependent: :destroy
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  belongs_to :parent_id, class_name: "Game", optional: true
  has_many :expansions, class_name: "Game",
                        foreign_key: "parent_id",
                        inverse_of: "parent",
                        dependent: :nullify

  # Validations
  validates :name, uniqueness: true, presence: true
  validates :category, presence: true
  validates :rating, default: 0, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
  validate :validate_parent

  def validate_parent
    if category == "main_game" && parent_id
      errors.add(:parent_id, "should be null")
    elsif category == "expansion" && Game.find_by(id: parent_id).nil?
      errors.add(:parent_id, "should be a valid game id")
    end
  end
end
