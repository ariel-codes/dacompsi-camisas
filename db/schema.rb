# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_06_194922) do
  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.date "start", null: false
    t.date "end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns_products", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "campaign_id", null: false
    t.index ["campaign_id", "product_id"], name: "index_campaigns_products_on_campaign_id_and_product_id"
    t.index ["product_id", "campaign_id"], name: "index_campaigns_products_on_product_id_and_campaign_id"
  end

  create_table "cart_products", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", null: false
    t.json "variations", default: {}, null: false
    t.index ["cart_id", "product_id"], name: "index_cart_products_on_cart_id_and_product_id"
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["product_id", "cart_id"], name: "index_cart_products_on_product_id_and_cart_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.boolean "closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.json "variations", default: {}, null: false
    t.string "thumb_path", null: false
    t.string "carousel_paths", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_products", "carts"
  add_foreign_key "cart_products", "products"
end
