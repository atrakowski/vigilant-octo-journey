FactoryBot.define do
  factory :admin do
    sequence(:username) { |n| "admin#{n}" }
    email { "#{username}@example.com" }
    password { "MW4ZKS4hV5L@tYV#baji&5f*" }
  end
end
