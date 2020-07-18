require 'rails_helper'

RSpec.describe 'POST /products', type: :request do
  let!(:url) { '/api/v1/products' }

  let!(:expected_payload) do
    {
      data: {
        id: '1',
        type: 'products',
        attributes: {
          name: 'Veuve Clicquot Ponsardin Brut 0.75 l.',
          description: 'Champagne',
          price: '75.0',
          tag_titles: []
        },
        relationships: {
          tags: {
            data: []
          }
        }
      }
    }.deep_stringify_keys
  end

  context 'when API is called with valid params' do
    let!(:params) do
      {
        data: {
          type: 'undefined',
          id: 'undefined',
          attributes: {
            name: 'Veuve Clicquot Ponsardin Brut 0.75 l.',
            description: 'Champagne',
            price: "75.0"
          }
        }
      }
    end

    it 'creates a product' do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(201)
      expect(json_response).to eq(expected_payload)
    end
  end

  context 'when product by that name already exists' do
    let!(:existing_product) { create(:product, name: 'Champagne') }
    let!(:params) do
      {
        data: {
          type: 'undefined',
          id: 'undefined',
          attributes: {
            name: 'Champagne',
            description: 'Champagne',
            price: "75.0"
          }
        }
      }
    end
    let!(:expected_error_payload) do
      {
        data: {
          error: 'ACTIVERECORD.RECORDINVALID',
          message: 'VALIDATION.FAILED:NAME.HAS.ALREADY.BEEN.TAKEN',
          status: 422
        }
      }.deep_stringify_keys
    end

    it 'returns an error' do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
      expect(json_response).to eq(expected_error_payload)
    end
  end

  context 'when params are empty' do
    let!(:params) do
      {
        data: {
          attributes: {}
        }
      }
    end

    it 'returns an error' do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
      expect(json_response["data"]["error"]).to eq('JSON_SCHEMA_VALIDATION_ERROR')
      expect(json_response["data"]["status"]).to eq(422)
      expect(json_response["data"]["mode"]).to eq("request")
      expect(json_response["data"]["message"].first).to include(
        "The property '#/data/attributes' did not contain a required property of 'name' in schema"
      )
    end
  end

  context 'when price is not parseable' do
    let!(:params) do
      {
        data: {
          type: 'undefined',
          id: 'undefined',
          attributes: {
            name: 'Champagne',
            description: 'Champagne',
            price: 'expensive'
          }
        }
      }
    end

    it 'returns an error' do
      post url, params: params.to_json, headers: json_headers

      expect(response).to have_http_status(422)
      expect(json_response["data"]["error"]).to eq('JSON_SCHEMA_VALIDATION_ERROR')
      expect(json_response["data"]["status"]).to eq(422)
      expect(json_response["data"]["mode"]).to eq("request")
    end
  end
end
