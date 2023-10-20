class Admin < ApplicationRecord
  # Include devise modules. Others available are:
  # :registerable, :recoverable, :rememberable, :confirmable, :lockable, :timeoutable, and :omniauthable
  devise(
    :database_authenticatable,
    :validatable,
    :trackable,
  )
end
