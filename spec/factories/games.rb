FactoryBot.define do
  factory :game do
    mode { 1 }
    release_date { "2025-05-16 12:25:48" }
    developer { Faker::Company.name }
    system_requirement
  end
end
