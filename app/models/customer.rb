class Customer < ApplicationRecord
  after_create :enqueue_registration_cleanup

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

  private

  def enqueue_registration_cleanup
    RegistrationCleanupJob.set(wait: 1.day).perform_later(self)
  end
end
