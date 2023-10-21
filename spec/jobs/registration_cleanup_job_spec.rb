require 'rails_helper'

RSpec.describe RegistrationCleanupJob do
  subject(:registration_cleanup_job) { described_class.new }

  describe "#perform" do
    subject(:result) { registration_cleanup_job.perform(customer) }

    context "when the customer has confirmed their email and thereby their registration" do
      let!(:customer) { create(:customer, :confirmed) }

      before { expect(customer).to be_confirmed }

      it "does nothing" do
        expect { result }.not_to change { Customer.count }
      end
    end

    context "when the customer has not yet confirmed their email and thereby their registration" do
      let!(:customer) { create(:customer) }

      before { expect(customer).not_to be_confirmed }

      it "destroys customer" do
        expect do
          result
        end.to change { Customer.count }.by(-1)
          .and change { Customer.exists?(id: customer.id) }.from(true).to(false)
      end
    end
  end
end
