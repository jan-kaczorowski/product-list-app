FactoryBot.define do
  factory :tag do
    title { Faker::Marketing.buzzwords }
  end
end
