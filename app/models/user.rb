class User < ApplicationRecord
  # Enums
  enum role: { contributor: 0, admin: 1 }

  # Associations
  has_many :critics, dependent: :destroy
  has_many :authentications, dependent: :destroy

  # Validations
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
end
