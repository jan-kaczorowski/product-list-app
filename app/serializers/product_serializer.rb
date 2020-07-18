# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  type :products
  attributes :id, :name, :description, :price
  attribute :tag_titles # (only reason for this one is to facilitate manual testing)
  has_many :tags

  # def tags
  #   object.tags.order(id: :asc)
  # end
end
