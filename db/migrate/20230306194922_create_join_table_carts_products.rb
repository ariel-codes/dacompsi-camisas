class CreateJoinTableCartsProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_products do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.json :variations, default: {}, null: false

      t.index [:cart_id, :product_id]
      t.index [:product_id, :cart_id]
    end
  end
end
