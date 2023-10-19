# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Home" do
  it "works as root URL" do
    visit root_url
    expect(page).to have_selector("h1", text: "Demo App")
    expect(page).to have_content("Lorem ipsum…")
  end
end
