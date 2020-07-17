# frozen_string_literal: true

class PolyMailer < OfferProduct
  MIN_QTY = 50
  MAX_QTY = 2000
  MATERIALS = {
    black: 0,
    transparent: 0.15
  }.freeze

  enum material: MATERIALS.keys

  validates :quantity,
            presence: true,
            numericality: { 
              greater_than_or_equal_to: MIN_QTY,
              less_than_or_equal_to: MAX_QTY
          }

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