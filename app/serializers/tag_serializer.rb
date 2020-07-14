class TagSerializer < ActiveModel::Serializer
  type :tags
  attributes :id, :title
end
