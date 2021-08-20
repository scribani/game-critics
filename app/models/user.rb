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

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github gitlab]

  # To be used with omniauth
  def self.from_omniauth(auth)
    authentication = Authentication.where(
      provider: auth.provider,
      uid: auth.uid
    ).first_or_initialize

    unless authentication.user
      user = find_by(email: auth.info.email)
      user ||= User.create(extract_user_data(auth))

      authentication.user = user
      authentication.save
    end

    authentication.user
  end

  def self.extract_user_data(auth)
    info = auth.info
    token = Devise.friendly_token[6, 14]
    username = info.nickname || info.name.downcase.gsub(" ", "_")
    {
      username: username,
      email: info.email,
      default_password: token,
      password: token
    }
  end

  private_class_method :extract_user_data
end
