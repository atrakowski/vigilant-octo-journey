# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin Administration" do
  context "when signed out" do
    let(:admin) { create(:admin) }

    before do
      sign_out admin
    end

    it "is unavailable" do
      visit admin_admins_path

      expect(page).not_to have_content(I18n.t("admins.admins.index.title"))
      expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
    end
  end

  context "when signed in as admin" do
    let(:admin) { create(:admin, username: "current_admin", email: "current_admin@example.com") }

    before do
      sign_in admin
    end

    it "can create a new admin" do
      visit admin_admins_path
      expect(page).to have_content(I18n.t("admins.admins.index.title"))
      click_on I18n.t("admins.shared.links.new_admin")
      expect(page).to have_content(I18n.t("admins.admins.new.title"))
      fill_in :admin_email, with: "new_admin@example.com"
      fill_in :admin_username, with: "new_admin"
      fill_in :admin_password, with: "abcd"*4
      fill_in :admin_password_confirmation, with: "abcd"*4
      fill_in :admin_first_name, with: "Jane"
      fill_in :admin_last_name, with: "Admin"

      expect do
        click_on I18n.t("helpers.submit.create", model: Admin.model_name.human)
      end.to change { Admin.count }.by(+1)

      created_admin = Admin.last
      expect(created_admin.username).to eql("new_admin")
      expect(created_admin.email).to eql("new_admin@example.com")
      expect(page).to have_content(I18n.t("admins.admins.create.success"))
      expect(page).to have_content(I18n.t("admins.admins.show.title"))
      expect(page).to have_content("new_admin@example.com")
      expect(page).to have_content("new_admin")
      expect(page).to have_content("Jane")
      expect(page).to have_content("Admin")
    end

    it "can edit an admin without changing their password" do
      another_admin = create(:admin, email: "another_admin@example.com")

      visit admin_admins_path
      expect(page).to have_content(I18n.t("admins.admins.index.title"))
      expect(page).to have_content("another_admin@example.com")
      within(page.find("div.card", text: "another_admin@example.com")) do
        click_on I18n.t("admins.admins.admin.edit")
      end
      fill_in :admin_email, with: "updated_admin@example.com"
      fill_in :admin_city, with: "Bonn"

      expect do
        click_on I18n.t("helpers.submit.update", model: Admin.model_name.human)
      end.not_to change { Admin.count }

      expect(page).to have_content(I18n.t("admins.admins.update.success"))
      expect(page).to have_content(I18n.t("admins.admins.show.title"))
      expect(page).not_to have_content("another_admin@example.com")
      expect(page).to have_content("updated_admin@example.com")
      expect(page).to have_content("Bonn")
      another_admin.reload
      expect(another_admin.email).to eql("updated_admin@example.com")
      expect(another_admin.city).to eql("Bonn")
    end

    it "can update an admin's password" do
      another_admin = create(:admin, email: "other_admin@example.com", password: "abcd" * 4, password_confirmation: "abcd" * 4)

      visit admin_admins_path
      expect(page).to have_content(I18n.t("admins.admins.index.title"))
      expect(page).to have_content("other_admin@example.com")
      within(page.find("div.card", text: "other_admin@example.com")) do
        click_on I18n.t("admins.admins.admin.edit")
      end
      fill_in :admin_password, with: "efgh" * 4
      fill_in :admin_password_confirmation, with: "efgh" * 4

      expect do
        click_on I18n.t("helpers.submit.update", model: Admin.model_name.human)
      end.not_to change { Admin.count }

      expect(page).to have_content(I18n.t("admins.admins.update.success"))
      another_admin.reload
      expect(another_admin.valid_password?("abcd" * 4)).to eql(false)
      expect(another_admin.valid_password?("efgh" * 4)).to eql(true)
    end

    it "can destroy an admin" do
      another_admin = create(:admin, email: "another_admin@example.com")

      visit admin_admins_path
      expect(page).to have_content(I18n.t("admins.admins.index.title"))
      expect(page).to have_content("current_admin@example.com")
      expect(page).to have_content("another_admin@example.com")

      expect do
        within(page.find("div.card", text: "another_admin@example.com")) do
          click_on I18n.t("admins.admins.admin.destroy")
        end
      end.to change { Admin.count }.by(-1)

      expect(page).to have_content(I18n.t("admins.admins.destroy.success"))
      expect(page).to have_content(I18n.t("admins.admins.index.title"))
      expect(page).to have_content(admin.email)
      expect(page).not_to have_content(another_admin.email)

      expect(Admin.exists?(email: "current_admin@example.com")).to eql(true)
      expect(Admin.exists?(email: "another_admin@example.com")).to eql(false)
    end
  end
end
