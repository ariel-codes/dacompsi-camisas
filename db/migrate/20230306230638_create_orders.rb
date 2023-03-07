class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :buyer, null: false, foreign_key: true
      t.integer :total_price, null: false
      t.boolean :paid, null: false, default: false
      t.boolean :fulfilled, null: false, default: false
      t.boolean :delivered, null: false, default: false

      t.timestamps
    end
  end
end
