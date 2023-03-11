# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to have_one(:event) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:project) }
end
