# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin do
  subject(:admin) { build(:admin) }

  it { is_expected.to validate_length_of(:password).is_at_least(16) }
end
