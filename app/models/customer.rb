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

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
