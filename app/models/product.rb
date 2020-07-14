class Product < ApplicationRecord
  include Taggable

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price,
            presence: true,
            numericality: { greater_than: 0 }
end
