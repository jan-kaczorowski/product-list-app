# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :taggables, through: :taggings

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }
end
