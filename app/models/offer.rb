# frozen_string_literal: true

class Offer < ApplicationRecord
  has_many :offer_products, dependent: :destroy
  belongs_to :client

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2
  }

  validates :status, presence: true
  validates :client, presence: true
  validates :offer_products, length: { minimum: 1 }
end
