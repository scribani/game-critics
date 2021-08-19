class InvolvedCompany < ApplicationRecord
  # Associations
  belongs_to :company
  belongs_to :game

  # Validations
  validates :company,
            uniqueness: { scope: :game, message: "and Game combination already taken" }
  validates :developer, :publisher, inclusion: { in: [true, false] }
end
