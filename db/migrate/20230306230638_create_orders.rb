class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :buyer, null: false, foreign_key: true
      t.integer :total_price, null: false

      t.string :payment_status, null: false, default: "pending"
      t.string :payment_preference_id

      t.string :token, null: false

      t.index :token, unique: true

      t.timestamps
    end
  end
end
