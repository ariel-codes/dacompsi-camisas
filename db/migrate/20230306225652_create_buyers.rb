class CreateBuyers < ActiveRecord::Migration[7.0]
  def change
    create_table :buyers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :telephone, null: false

      t.timestamps
    end
  end
end
