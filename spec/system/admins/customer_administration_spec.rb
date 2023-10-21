# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Customer Customeristration" do
  context "when signed out" do
    let(:admin) { create(:admin) }

    before do
      sign_out admin
    end

    it "is unavailable" do
      visit admin_customers_path

      expect(page).not_to have_content(I18n.t("admins.customers.index.title"))
      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
    end
  end

  context "when signed in as admin" do
    let(:admin) { create(:admin, email: "current_admin@example.com") }

    before do
      sign_in admin
    end

    it "can create a new customer (which is also immediately confirmed)" do
      visit admin_customers_path
      expect(page).to have_content(I18n.t("admins.customers.index.title"))
      click_on I18n.t("admins.customers.index.new_customer")
      expect(page).to have_content(I18n.t("admins.customers.new.title"))
      fill_in :customer_email, with: "new_customer@example.com"
      fill_in :customer_password, with: "abcd"*4
      fill_in :customer_password_confirmation, with: "abcd"*4
      fill_in :customer_first_name, with: "Jane"
      fill_in :customer_last_name, with: "Customer"

      expect do
        click_on I18n.t("helpers.submit.create", model: Customer.model_name.human)
      end.to change { Customer.count }.by(+1)

      created_customer = Customer.last
      expect(created_customer.email).to eql("new_customer@example.com")
      expect(created_customer).to be_confirmed
      expect(page).to have_content(I18n.t("admins.customers.create.success"))
      expect(page).to have_content(I18n.t("admins.customers.show.title"))
      expect(page).to have_content("new_customer@example.com")
      expect(page).to have_content("Jane")
      expect(page).to have_content("Customer")
    end

    it "can edit a customer without changing their password and with reconfirming email" do
      customer = create(:customer, email: "some_customer@example.com", first_name: "SomeFirstName", city: nil)

      visit admin_customers_path
      expect(page).to have_content(I18n.t("admins.customers.index.title"))
      expect(page).to have_content("some_customer@example.com")
      within(page.find("div.card", text: "some_customer@example.com")) do
        click_on I18n.t("admins.customers.customer.edit")
      end
      fill_in :customer_email, with: "updated_customer@example.com"
      fill_in :customer_first_name, with: "OtherFirstName"
      fill_in :customer_city, with: "Bonn"

      expect do
        click_on I18n.t("helpers.submit.update", model: Customer.model_name.human)
      end.not_to change { Customer.count }

      expect(page).to have_content(I18n.t("admins.customers.update.success"))
      expect(page).to have_content(I18n.t("admins.customers.show.title"))
      expect(page).not_to have_content("some_customer@example.com")
      expect(page).to have_content("updated_customer@example.com")
      expect(page).not_to have_content("SomeFirstName")
      expect(page).to have_content("OtherFirstName")
      expect(page).to have_content("Bonn")
      customer.reload
      expect(customer.email).to eql("updated_customer@example.com")
      expect(customer.first_name).to eql("OtherFirstName")
      expect(customer.city).to eql("Bonn")
    end

    it "can update a customer's password" do
      customer = create(:customer, email: "customer@example.com", password: "abcd" * 4, password_confirmation: "abcd" * 4)

      visit admin_customers_path
      expect(page).to have_content(I18n.t("admins.customers.index.title"))
      expect(page).to have_content("customer@example.com")
      within(page.find("div.card", text: "customer@example.com")) do
        click_on I18n.t("admins.customers.customer.edit")
      end
      fill_in :customer_password, with: "efgh" * 4
      fill_in :customer_password_confirmation, with: "efgh" * 4

      expect do
        click_on I18n.t("helpers.submit.update", model: Customer.model_name.human)
      end.not_to change { Customer.count }

      expect(page).to have_content(I18n.t("admins.customers.update.success"))
      customer.reload
      expect(customer.valid_password?("abcd" * 4)).to eql(false)
      expect(customer.valid_password?("efgh" * 4)).to eql(true)
    end

    it "can destroy a customer" do
      customer = create(:customer, email: "customer@example.com")
      other_customer = create(:customer, email: "other_customer@example.com")

      visit admin_customers_path
      expect(page).to have_content(I18n.t("admins.customers.index.title"))
      expect(page).to have_content("customer@example.com")
      expect(page).to have_content("other_customer@example.com")

      expect do
        within(page.find("div.card", text: "other_customer@example.com")) do
          click_on I18n.t("admins.customers.customer.destroy")
        end
      end.to change { Customer.count }.by(-1)

      expect(page).to have_content(I18n.t("admins.customers.destroy.success"))
      expect(page).to have_content(I18n.t("admins.customers.index.title"))
      expect(page).to have_content(customer.email)
      expect(page).not_to have_content(other_customer.email)

      expect(Customer.exists?(email: "customer@example.com")).to eql(true)
      expect(Customer.exists?(email: "other_customer@example.com")).to eql(false)
    end
  end
end
