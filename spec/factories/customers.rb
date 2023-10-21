FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "customer#{n}@example.com" }
    password { "6cMVQbheq9&R9C#SoB4$nY2j" }
    first_name { "Erika" }
    last_name { "Mustermann" }

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end

    trait :approved do
      approved { true }
    end

    trait :locked do
      locked_at { Time.zone.now }
      failed_attempts { 42 }
    end
  end
end
