class Tag < ApplicationRecord
  has_many :taggings
  has_many :taggables, through: :taggings

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
end
