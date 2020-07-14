class ProductSerializer < ActiveModel::Serializer
  type :products
  attributes :id, :name, :description, :price
  attribute :tag_titles # (only reason for this one is to facilitate manual testing)
  has_many :tags, serializer: TagSerializer

  def tags
    object.tags.order(id: :asc)
  end
end
