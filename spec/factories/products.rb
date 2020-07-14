FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    price { Faker::Number.between(from: 1.0, to: 100.0).round(2) }
    tags { create_list(:tag, 2) }

    trait :without_tags do
      tags { [] }
    end
  end
end
