# frozen_string_literal: true

class OfferProductBuilder
  def initialize(params, offer)
    @params = params
    @offer = offer
  end

  attr_reader :params, :offer

  def call
    product_type = params.delete(:product_type)
    product_klass = product_klass_for_name(product_type)

    product = product_klass.new(params)
    product.offer = offer

    product.validate!
    product.calculated_price = product_klass.calculate_price(product)
    product.save!
    product
  rescue StandardError => e
    # that'd be the place for some proper error handling
    raise e
  end

  private

  def validate_price_params!(product_type, params)
    product_type.class.validate_price_params! params
  end

  def product_klass_for_name(product_type)
    unless OfferProduct.descendants.map(&:name).include?(product_type)
      raise StandardError, "Unsupported product type"
    end

    product_type.constantize
  end
end

