require "rails_helper"

RSpec.describe "DELETE /products/:id", type: :request do
  context "when existing product is deleted" do
    let!(:product) { create(:product) }
    let!(:url) { "/api/v1/products/#{product.id}" }

    it "deletes product" do
      delete url
      expect(response).to have_http_status(204)
      expect(response.body).to be_empty
    end
  end
  
  context "when id of an object to be deleted is invalid" do
    let!(:url) { "/api/v1/products/invalidId" }

    it "returns error" do
      delete url

      expect(response).to have_http_status(404)
      expect(response.body).to be_empty
    end
  end
end
