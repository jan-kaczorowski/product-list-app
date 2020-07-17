class AddOfferProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :security_token, null: false
      t.timestamps
    end

    create_table :offers do |t|
      t.integer :status, null: false, default: 0
      t.references :client, foreign_key: true, null: false
      t.timestamps
    end

    create_table :offer_products do |t|
      t.string :type, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :length
      t.integer :material
      t.integer :quantity, null: false
      t.decimal :calculated_price, null: false, precision: 10, scale: 4
      t.references :offer, foreign_key: true, null: false
      t.timestamps
    end
  end
end
