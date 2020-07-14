require "rails_helper"

RSpec.describe "PATCH /tags/:id", type: :request do
  let!(:tag) { create(:tag, title: "Appetizer") }
  let!(:url) { "/api/v1/tags/#{tag.id}" }

  let!(:expected_payload) do
    {
      data: {
        id: "1",
        type: "tags",
        attributes: {
          title: "Dessert"
        }
      }
    }.deep_stringify_keys
  end

  context "when API is called with valid params" do
    let!(:params) do
      {
        data: {
          type: "tags",
          id: tag.id.to_s,
          attributes: {
            title: "Dessert"
          }
        }
      }
    end

    it "updates a tag" do
      patch url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(200)
      expect(json_response).to eq(expected_payload)
    end
  end

  context "when id is invalid" do
    let!(:url) { "/api/v1/tags/invalid-id" }
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
          message: "COULDNT.FIND.TAG.WITH.ID=INVALID-ID",
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
