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

  context "when params are empty" do
    let!(:params) do
      {
        data: {	
          attributes: {}
        }
      }
    end

    it "returns an error" do
      patch url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
      expect(json_response).to eq(expected_payload)
    end
  end
end

