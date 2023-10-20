FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { "MW4ZKS4hV5L@tYV#baji&5f*" }
  end
end
