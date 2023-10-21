class RegistrationCleanupJob < ApplicationJob
  queue_as :default

  def perform(customer)
    customer.destroy! unless customer.confirmed?
  end
end
