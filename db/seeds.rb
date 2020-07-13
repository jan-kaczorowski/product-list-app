# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if ENV['CLEAR_DB'] == "1"
  Product.delete_all
  Product.connection.execute("UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='products';")
end

Product.create!(
  [
    {
      name: "Coke",
      description: "12 Oz Bottle",
      price: 1.99,
    },
    {
      name: "Montecristo Churchill Anejados",
      description: "Allowing the cigars time to mature before they are smoked affords a mellower " \
                   "taste with the flavours melding together into a complex masterpiece. " \
                   "The Churchill size makes for a long smoke that is not too powerful nor too harsh",
      price: 19.0
    },
    {
      name: "Montecristo 80 Aniversario",
      description: "The Montecristo 80 Aniversario starts medium with some woodsiness, waffle cones, acorns and a touch of burning woods",
      price: 26.0
    },
    {
      name: "Montecristo No.1. Box of 25 pcs.",
      description: "The Montecristo No.1 is the largest of the Montecristo numbered series, which " \
                   "includes some of the World’s most famous cigars.",
      price: 494.0
    }
  ]
)