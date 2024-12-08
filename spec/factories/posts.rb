FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Lorem.paragraph }
    association :user

    trait :invalid do
      title { nil }
      content { nil }
    end
  end
end
