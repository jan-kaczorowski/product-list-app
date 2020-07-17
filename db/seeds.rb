# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if ENV['CLEAR_DB'] == "1"
  Product.delete_all
  Tag.delete_all
  Tagging.delete_all
  Product.connection.execute("UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME IN ('products', 'tags');")
  OfferProduct.delete_all
  Offer.delete_all
  Client.delete_all
  Client.connection.execute(
    "UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME IN ('clients', 'offers', 'offer_product');"
  )
end

Tag.create!(
  [
    { id: 1, title: "Soft Drink" },
    { id: 2, title: "Beverage" },
    { id: 3, title: "Calorie Free" },
    { id: 4, title: "Cuban" }
  ]
)

Product.create!(
  [
    {
      name: "Coke",
      description: "12 Oz Bottle",
      price: 1.99,
      tag_ids: [1, 2]
    },
    {
      name: "Montecristo Churchill Anejados",
      description: "Allowing the cigars time to mature before they are smoked affords a mellower " \
                   "taste with the flavours melding together into a complex masterpiece. " \
                   "The Churchill size makes for a long smoke that is not too powerful nor too harsh",
      price: 19.0,
      tag_ids: [3, 4]
    },
    {
      name: "Montecristo 80 Aniversario",
      description: "The Montecristo 80 Aniversario starts medium with some woodsiness, waffle cones, acorns and a touch of burning woods",
      price: 26.0,
      tag_ids: [3, 4]
    },
    {
      name: "Montecristo No.1. Box of 25 pcs.",
      description: "The Montecristo No.1 is the largest of the Montecristo numbered series, which " \
                   "includes some of the World’s most famous cigars.",
      price: 494.0,
      tag_ids: [3, 4]
    }
  ]
)

Client.create!(
  [
    {name: "Good client", security_token: SecureRandom.uuid, id: 1 }
  ]
)

Offer.create!(
  [
    {
      id: 1,
      status: "pending",
      client_id: 1
    }
  ]
)

OfferProduct.create!(
  [
    {
      id: 1,
      type: "MailerBox",
      width: 100,
      height: 100,
      length: 50,
      quantity: 300,
      calculated_price: 7_500,
      offer_id: 1
    },
    {
      id: 2,
      type: "PolyMailer",
      width: 100,
      height: 100,
      material: "transparent",
      quantity: 300,
      calculated_price: 15_000,
      offer_id: 1
    }
  ]
)
