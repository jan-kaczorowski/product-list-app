require "rails_helper"

RSpec.describe "PATCH /products/:id", type: :request do
  let!(:product) { create(:product, name: "Champagne") }
  let!(:url) { "/api/v1/products/#{product.id}" }

  let(:expected_payload) do
    {
      data: {
        id: product.id.to_s,
        type: "products",
        attributes: {
          name: "Beer",
          description: product.description,
          price: "222.0",
          tag_titles: product.tag_titles
        },
        relationships: {
          tags: {
            data: product.tags.sort.map do |tag|
              { id: tag.id.to_s, type: "tags" }
            end
          }
        }
      }
    }.deep_stringify_keys
  end

  context "when API is called with valid params" do
    let!(:new_tags) { ["Beverage", "Calorie Free"] }
    let!(:params) do
      {
        data: {
          type: "products",
          id: product.id.to_s,
          attributes: {
            name: "Beer",
            price: "222.0",
            tags: new_tags
          }
        }
      }
    end

    it "updates a product" do
      patch url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(200)
      product.reload
      expect(json_response).to eq(expected_payload)

      tag_titles = json_response["data"]["attributes"]["tag_titles"]
      expect(
        new_tags.all? { |e| tag_titles.include?(e) }
      ).to be true
    end
  end

  context "when id is invalid" do
    let!(:url) { "/api/v1/products/invalid-id" }
    let!(:params) do
      {
        data: {
          type: "products",
          attributes: {}
        }
      }
    end
    let!(:expected_error_payload) do
      {
        data: {
          error: "ACTIVERECORD.RECORDNOTFOUND",
          message: "COULDNT.FIND.PRODUCT.WITH.ID=INVALID-ID",
          status: 404
        }
      }.deep_stringify_keys
    end

    it "returns an error" do
      patch url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(404)
      expect(json_response).to eq(expected_error_payload)
    end
  end
end
