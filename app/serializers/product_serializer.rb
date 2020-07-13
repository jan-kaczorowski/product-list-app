class ProductSerializer < ActiveModel::Serializer
  type :products
  attributes :id, :name, :description, :price, :created_at
end
