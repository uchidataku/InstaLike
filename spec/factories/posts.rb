FactoryBot.define do
  factory :post do
    picture { "MyString" }
    content { "MyText" }
    user { nil }
  end
end
