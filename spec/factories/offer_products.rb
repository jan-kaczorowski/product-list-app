FactoryBot.define do
  factory :offer_product do
    offer { build(:offer) }
    width { Faker::Number.between(from: 0, to: 200) }
    height { Faker::Number.between(from: 0, to: 200) }

    trait :mailer_box do
      quantity { Faker::Number.between(from: 200, to: 1000) }
      length { Faker::Number.between(from: 0, to: 200) }
    end

    trait :poly_mailer do
      quantity { Faker::Number.between(from: 50, to: 2000) }
      material { "transparent" }
    end
  end
end
