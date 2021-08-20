class Company < ApplicationRecord
  # Associations
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy
  has_one_attached :cover

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :cover, presence: { message: "can't be blank" }
end
