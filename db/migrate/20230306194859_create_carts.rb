class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.boolean :closed, default: false, null: false

      t.timestamps
    end
  end
end
