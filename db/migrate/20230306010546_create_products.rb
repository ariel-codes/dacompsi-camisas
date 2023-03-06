class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.json :variations, default: {}, null: false
      t.string :thumb_path, null: false
      t.string :carousel_paths, array: true, null: false
      t.string :type

      t.timestamps
    end
  end
end
