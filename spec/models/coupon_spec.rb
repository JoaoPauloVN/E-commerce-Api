require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:discount_value) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }

  it "is invalid when the date is before the current date" do
    subject.due_date = 1.day.ago
    subject.valid?
    expect(subject.errors).to have_key(:due_date)
  end

  it "is invalid when the date is equals to the current date" do
    subject.due_date = Time.zone.today
    subject.valid?
    expect(subject.errors).to have_key(:due_date)
  end

  it "is valid when the date is after the current date" do
    subject.due_date = 1.day.from_now
    subject.valid?
    expect(subject.errors).not_to have_key(:due_date)
  end
end
