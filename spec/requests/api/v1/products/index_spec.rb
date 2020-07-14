require "rails_helper"

RSpec.describe "GET /products", type: :request do
  let!(:product1) { create(:product) }
  let!(:product2) { create(:product) }

  let!(:url) { "/api/v1/products" }

  let!(:expected_payload) do
    {
      data: [
        {
          id: product1.id.to_s,
          type: "products",
          attributes: {
            name: product1.name,
            description: product1.description,
            price: product1.price.to_s,
            tag_titles: product1.tag_titles.sort
          },
          relationships: {
            tags: {
              data: product1.tags.sort.map do |tag|
                { id: tag.id.to_s, type: "tags" }
              end
            }
          }
        },
        {
          id: product2.id.to_s,
          type: "products",
          attributes: {
            name: product2.name,
            description: product2.description,
            price: product2.price.to_s,
            tag_titles: product2.tag_titles.sort
          },
          relationships: {
            tags: {
              data: product2.tags.sort.map do |tag|
                { id: tag.id.to_s, type: "tags" }
              end
            }
          }
        }
      ],
      included: (product1.tags + product2.tags).map do |tag|
        {
          id: tag.id.to_s,
          type: "tags",
          attributes: {
            title: tag.title
          }
        }
      end
    }.deep_stringify_keys
  end

  context "when API is called for products index" do
    it "returns a list of products" do
      get url
      expect(response).to have_http_status(200)
      expect(json_response).to eq(expected_payload)
    end
  end
end
