module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
  end

  def tag!(title)
    tag = Tag.find_or_create_by!(title: title.strip)
    taggings.find_or_create_by!(tag_id: tag.id)
  end

  def tag_titles
    tags.map(&:title).sort
  end
end
