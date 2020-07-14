require "rails_helper"

RSpec.describe "GET /products", type: :request do
  let(:product1) { create(:product) }
  let(:product2) { create(:product) }

  let(:url) { "/api/v1/products" }

  it "returns a list of products" do
    get url
    expect(response).to have_http_status(200)
    byebug
    # expect(response).to render_template(:new)

    # post "/widgets", :params => { :widget => {:name => "My Widget"} }

    # expect(response).to redirect_to(assigns(:widget))
    # follow_redirect!

    # expect(response).to render_template(:show)
    # expect(response.body).to include("Widget was successfully created.")
  end

  # it "does not render a different template" do
  #   get "/widgets/new"
  #   expect(response).to_not render_template(:show)
  # end
end
