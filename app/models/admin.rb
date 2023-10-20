class Admin < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :username, with: ->(username) { username.strip.downcase }

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: true }

  # Include devise modules. Others available are:
  # :registerable, :recoverable, :rememberable, :confirmable, :lockable, :timeoutable, and :omniauthable
  devise(
    :database_authenticatable,
    :validatable,
    :trackable,
    authentication_keys: [:login],
    case_insensitive_keys: [:login],
    strip_whitespace_keys: [:login],
  )

  def login
    email.presence || username.presence
  end

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(email: login).or(where(username: login)).take
  end
end
