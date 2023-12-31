# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Customer Authentication" do
  context "when signed out" do
    let(:customer) { create(:customer) }

    before do
      sign_out customer
    end

    it "makes customer resources unavailable" do
      visit customer_root_path

      expect(page).not_to have_content(I18n.t("customers.dashboards.show.welcome"))
      expect(page).not_to have_current_path(customer_root_path)

      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).to have_current_path(new_customer_session_path)
    end
  end

  context "when signed in, but not confirmed yet" do
    let(:customer) { create(:customer) }

    before do
      sign_in customer
    end

    it "makes customer resources unavailable" do
      visit customer_root_path

      expect(page).not_to have_content(I18n.t("customers.dashboards.show.welcome"))
      expect(page).not_to have_current_path(customer_root_path)

      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).to have_current_path(new_customer_session_path)
    end
  end

  context "when signed in and confirmed, but not admin approved yet" do
    let(:customer) { create(:customer, :confirmed) }

    before do
      sign_in customer
    end

    it "makes customer resources unavailable" do
      visit customer_root_path

      expect(page).not_to have_content(I18n.t("customers.dashboards.show.welcome"))
      expect(page).not_to have_current_path(customer_root_path)

      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).to have_current_path(new_customer_session_path)
    end
  end

  context "when signed in and confirmed and admin approved" do
    let(:customer) { create(:customer, :confirmed, :approved) }

    before do
      sign_in customer
    end

    it "shows e.g. customer dashboard" do
      visit customer_root_path

      expect(page).not_to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).not_to have_current_path(new_customer_session_path)

      expect(page).to have_content(I18n.t("customers.dashboards.show.welcome"))
      expect(page).to have_current_path(customer_root_path)
    end
  end
end
