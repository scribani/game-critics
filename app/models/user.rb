class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Enums
  enum role: { contributor: 0, admin: 1 }

  # Associations
  has_many :critics, dependent: :destroy
  has_many :authentications, dependent: :destroy

  # Validations
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
end
