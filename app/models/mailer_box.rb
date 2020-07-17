# frozen_string_literal: true

class MailerBox < OfferProduct
  MIN_QTY = 200
  MAX_QTY = 1000

  validates :quantity,
            presence: true,
            numericality: { 
              greater_than_or_equal_to: MIN_QTY,
              less_than_or_equal_to: MAX_QTY
          }

  validates :length,
            presence: true,
            numericality: { 
              greater_than: 0,
              less_than_or_equal_to: MAX_LENGTH
            }

  def self.calculate_price(product)
    (product.width + product.height + product.length) \
      * ARBITRARY_FACTOR * product.quantity
  end
end

