require "rails_helper"

RSpec.describe "DELETE /tags/:id", type: :request do
  context "when existing tag is deleted" do
    let!(:tag) { create(:tag) }
    let!(:url) { "/api/v1/tags/#{tag.id}" }

    it "deletes tags" do
      delete url
      expect(response).to have_http_status(204)
      expect(response.body).to be_empty
    end
  end

  context "when id of an object to be deleted is invalid" do
    let!(:url) { "/api/v1/tags/invalidId" }
    let!(:expected_error_payload) do
      {
        data: {
          error: "ACTIVERECORD.RECORDNOTFOUND",
          message: "COULDNT.FIND.TAG.WITH.ID=INVALIDID",
          status: 404
        }
      }.deep_stringify_keys
    end

    it "returns error" do
      delete url

      expect(response).to have_http_status(404)
      expect(json_response).to eq(expected_error_payload)
    end
  end
end
