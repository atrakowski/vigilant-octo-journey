FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "customer#{n}@example.com" }
    password { "6cMVQbheq9&R9C#SoB4$nY2j" }

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end
  end
end
