# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin Authentication" do
  context "when signed out" do
    let(:admin) { create(:admin) }

    before do
      sign_out admin
    end

    it "forces me to sign in" do
      visit admin_root_path

      expect(page).not_to have_content(I18n.t("admins.dashboards.show.welcome"))
      expect(page).not_to have_current_path(admin_root_path)

      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).to have_current_path(new_admin_session_path)
    end
  end

  context "when signed in as customer" do
    let(:customer) { create(:customer, :confirmed) }

    before do
      sign_in customer
    end

    it "does not show admin dashboard" do
      visit admin_root_path

      expect(page).not_to have_content(I18n.t("admins.dashboards.show.welcome"))
      expect(page).not_to have_current_path(admin_root_path)

      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).to have_current_path(new_admin_session_path)
    end
  end

  context "when signed in as admin" do
    let(:admin) { create(:admin) }

    before do
      sign_in admin
    end

    it "shows admin dashboard" do
      visit admin_root_path

      expect(page).not_to have_content(I18n.t("devise.sessions.new.sign_in"))
      expect(page).not_to have_current_path(new_admin_session_path)

      expect(page).to have_content(I18n.t("admins.dashboards.show.welcome"))
      expect(page).to have_current_path(admin_root_path)
    end
  end
end
