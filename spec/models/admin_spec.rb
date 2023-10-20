# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin do
  subject(:admin) { build(:admin) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(16) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value("admin1@example.com").for(:email) }
  it { is_expected.not_to allow_value("admin1").for(:email) }
  it { is_expected.not_to allow_value("example.com").for(:email) }
  it { is_expected.not_to allow_value("@example.com").for(:email) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
end
