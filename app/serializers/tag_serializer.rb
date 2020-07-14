# frozen_string_literal: true

class TagSerializer < ActiveModel::Serializer
  type :tags
  attributes :id, :title
end
