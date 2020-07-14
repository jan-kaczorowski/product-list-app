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

    it "returns error" do
      delete url
      #byebug
      expect(response).to have_http_status(404)
      expect(response.body).to be_empty
    end
  end
end
