# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Customer Registrations" do
  it "creates a customer" do
    customer_attributes = attributes_for(:customer)

    expect do
      post customer_registration_url, params: { customer: customer_attributes }
    end.to change { Customer.count }.by(+1)
  end

  it "ignores internal attributes on create" do
    customer_attributes = attributes_for(:customer)

    expect do
      post customer_registration_url, params: { customer: customer_attributes.merge(confirmed_at: Time.zone.now) }
    end.to change { Customer.count }.by(+1)

    expect(Customer.last).not_to be_confirmed
  end

  context "when signed in" do
    let(:customer) { create(:customer, :confirmed, city: nil, password: "abcd" * 4) }

    before do
      sign_in customer
    end

    it "updates a customer without changing their password" do
      expect do
        patch customer_registration_url, params: { customer: { city: "Bonn", current_password: "abcd" * 4 } }
      end.not_to change { Admin.count }

      customer.reload
      expect(customer.city).to eql("Bonn")
      expect(customer.valid_password?("abcd" * 4)).to eql(true)
    end

    it "updates a customer password" do
      expect do
        patch customer_registration_url, params: { customer: { password: "efgh" * 4, password_confirmation: "efgh" * 4, current_password: "abcd" * 4 } }
      end.not_to change { Admin.count }

      customer.reload
      expect(customer.city).to eql(nil)
      expect(customer.valid_password?("efgh" * 4)).to eql(true)
    end
  end
end
