# frozen_string_literal: true

class OfferProduct < ApplicationRecord
  belongs_to :offer

  MAX_WIDTH = 200
  MAX_HEIGHT = 200
  MAX_LENGTH = 200
  ARBITRARY_FACTOR = 0.1

  validates :offer, presence: true
  validates :width,
            presence: true,
            numericality: { 
              greater_than: 0,
              less_than_or_equal_to: MAX_WIDTH 
            }
  validates :height,
            presence: true,
            numericality: { 
              greater_than: 0,
              less_than_or_equal_to: MAX_HEIGHT
            }

  def self.calculate_price(params)
    raise NotImplementedError
  end
end
