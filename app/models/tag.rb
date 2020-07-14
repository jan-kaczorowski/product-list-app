class Tag < ApplicationRecord
  has_many :taggings
  has_many :taggables, through: :taggings

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }
end
