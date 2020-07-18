# frozen_string_literal: true

class PolyMailer < OfferProduct
  MIN_QTY = 50
  MAX_QTY = 2000
  MATERIALS = {
    black: 0,
    transparent: 0.15
  }.freeze

  include QuantityValidation

  enum material: MATERIALS.keys

  validates :material,
            presence: true,
            inclusion: { in: MATERIALS.keys.map(&:to_s) }

  def self.calculate_price(product)
    (product.width + product.height) \
      * (ARBITRARY_FACTOR + material_price_modifier(product.material)) \
      * product.quantity
  end

  def self.material_price_modifier(material)
    MATERIALS[material.to_sym]
  end
end