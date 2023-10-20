class Customer < ApplicationRecord
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
