class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :taggable, polymorphic: true, index: true
      t.references :tag, index: true
    end
  end
end
