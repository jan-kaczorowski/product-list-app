FactoryBot.define do
  factory :client do
    name { Faker::Commerce.product_name }
    security_token { SecureRandom.uuid }
  end
end
