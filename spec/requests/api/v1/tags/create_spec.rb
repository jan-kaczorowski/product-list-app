require "rails_helper"

RSpec.describe "POST /tags", type: :request do
  let!(:url) { "/api/v1/tags" }

  let!(:expected_payload) do
    {
      data: {
          id: "1",
          type: "tags",
          attributes: {
            title: "Appetizer"
          }
      }
    }.deep_stringify_keys
  end

  context "when API is called with valid params" do
    let!(:params) do
      {
        data: {	
          type: "undefined",
          id: "undefined",
          attributes: {
            title: "Appetizer"
          }
        }
      }
    end

    it "creates a tag" do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(201)
      expect(json_response).to eq(expected_payload)
    end
  end

  context "when tag already exists" do
    let!(:existing_tag) { create(:tag, title: "Appetizer") }
    let!(:params) do
      {
        data: {	
          type: "undefined",
          id: "undefined",
          attributes: {
            title: "Appetizer"
          }
        }
      }
    end

    it "returns an error" do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
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
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
      expect(json_response).to eq(expected_payload)
    end
  end
end

