FactoryBot.define do
  factory :user do
    name { "Example" }
    sequence(:user_name) { |n| "example#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end