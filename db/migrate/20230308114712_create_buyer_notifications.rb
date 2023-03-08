class CreateBuyerNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :buyer_notifications do |t|
      t.references :buyer, null: false, foreign_key: true
      t.string :notification

      t.index [:notification, :buyer_id], unique: true

      t.timestamps
    end
  end
end
