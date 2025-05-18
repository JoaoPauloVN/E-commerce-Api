FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { 1 }
    discount_value { Faker::Commerce.price(range: 1.00..100.00) }
    due_date { 1.day.from_now }
  end
end
