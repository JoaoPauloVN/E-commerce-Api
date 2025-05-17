FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { 1 }
    discount_value { Faker::Commerce.price(range: 1.00..100.00) }
    due_date { "2025-05-17 09:03:14" }
  end
end
