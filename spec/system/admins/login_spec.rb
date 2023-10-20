# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin Login" do
  let(:admin) { create(:admin) }

  it "accepts username and password" do
    visit new_admin_session_path

    expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
    fill_in :admin_login, with: admin.email
    fill_in :admin_password, with: admin.password
    click_on I18n.t("admins.sessions.new.sign_in")

    expect(page).to have_content(I18n.t("admins.dashboards.show.welcome"))
    expect(page).to have_current_path(admin_root_path)
  end

  it "accepts username and password" do
    visit new_admin_session_path

    expect(page).to have_content(I18n.t("devise.sessions.new.sign_in"))
    fill_in :admin_login, with: admin.username
    fill_in :admin_password, with: admin.password
    click_on I18n.t("admins.sessions.new.sign_in")

    expect(page).to have_content(I18n.t("admins.dashboards.show.welcome"))
    expect(page).to have_current_path(admin_root_path)
  end
end
