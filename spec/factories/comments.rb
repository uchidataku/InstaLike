FactoryBot.define do
  factory :comment do
    text { "MyText" }
    post { nil }
    user { nil }
  end
end
