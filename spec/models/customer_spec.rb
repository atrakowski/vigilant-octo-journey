# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  subject(:customer) { build(:customer) }

  it { is_expected.to validate_length_of(:password).is_at_least(16) }
end
