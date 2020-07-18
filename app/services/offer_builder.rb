# frozen_string_literal: true

class OfferBuilder
  def initialize(params)
    @params = params
    @products = []
  end

  attr_reader :params, :offer, :products

  def call
    ActiveRecord::Base.transaction do
      create_offer

      process_products

      offer.offer_products = products
      offer.save!
    end
  rescue StandardError => e
    # that'd be the place for some proper error handling
    delete_offer # cleanup
    raise e
  end

  private

  def process_products
    products_params = params[:products]

    products_params.each do |product_params|
      product = OfferProductBuilder.new(product_params, offer).call
      @products.push(product)
    end
  end

  def create_offer
    client_name = params.fetch(:client_name)
    client = Client.find_by_name!(client_name)

    @offer = Offer.create!(client: client, status: :pending)
  end

  def delete_offer
    return if offer.nil?

    offer.destroy
  end
end

