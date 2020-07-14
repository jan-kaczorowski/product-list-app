require 'rails_helper'

RSpec.describe 'GET /tags', type: :request do
  let!(:tag1) { create(:tag) }
  let!(:tag2) { create(:tag) }

  let!(:url) { '/api/v1/tags' }

  let!(:expected_payload) do
    {
      data: [
        {
          id: tag1.id.to_s,
          type: 'tags',
          attributes: {
            title: tag1.title
          }
        },
        {
          id: tag2.id.to_s,
          type: 'tags',
          attributes: {
            title: tag2.title
          }
        }
      ]
    }.deep_stringify_keys
  end

  context 'when API is called for tags index' do
    it 'returns a list of tags' do
      get url
      expect(response).to have_http_status(200)
      expect(json_response).to eq(expected_payload)
    end
  end
end
