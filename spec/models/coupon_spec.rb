require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:discount_value) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }
end
