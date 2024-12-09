FactoryBot.define do
  factory :comment do
    name { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    association :post

    trait :invalid do
      name { nil }
      content { nil }
    end
  end
end
