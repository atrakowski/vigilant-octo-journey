class Customer < ApplicationRecord
  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  # Include devise modules. Others available are:
  # :omniauthable
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :confirmable,
    :lockable,
    :timeoutable,
  )
end
