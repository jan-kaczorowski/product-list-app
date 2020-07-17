FactoryBot.define do
  factory :offers do
    status { :pending }
    client { create(:client) }
    offer_products { create_list(:offer_products) }
  end
end
