# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  subject(:customer) { build(:customer) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(16) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value("admin1@example.com").for(:email) }
  it { is_expected.not_to allow_value("admin1").for(:email) }
  it { is_expected.not_to allow_value("example.com").for(:email) }
  it { is_expected.not_to allow_value("@example.com").for(:email) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  context "after successful create" do
    include ActiveSupport::Testing::TimeHelpers

    it "enqueues a registration cleanup job" do
      freeze_time do
        expect do
          expect(customer.save).to eql(true)
        end.to change { described_class.count }.by(+1)
        expect(RegistrationCleanupJob).to have_been_enqueued.with(customer).at(1.day.from_now)
      end
    end
  end

  context "after failed create" do
    it "does not enqueue a registration cleanup job" do
      expect do
        customer.email = nil
        expect(customer.save).to eql(false)
      end.not_to change { described_class.count }
      expect(RegistrationCleanupJob).not_to have_been_enqueued
    end
  end
end
