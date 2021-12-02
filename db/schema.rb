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

ActiveRecord::Schema.define(version: 2021_12_01_115745) do

  create_table "sale_details", force: :cascade do |t|
    t.integer "apn_code"
    t.float "rrp"
    t.float "last_buy_price"
    t.string "item_description"
    t.string "author"
    t.string "product_category"
    t.integer "actual_stock_on_hand"
    t.date "trans_date"
    t.date "trans_time"
    t.string "trans_document_number"
    t.string "trans_reference_number"
    t.integer "trans_quantity"
    t.float "trans_total_extax_value"
    t.float "trans_total_tax"
    t.float "trans_total_discount_given"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trans_details", force: :cascade do |t|
    t.integer "apn_code"
    t.float "rrp"
    t.float "last_buy_price"
    t.string "item_description"
    t.string "author"
    t.string "product_category"
    t.integer "actual_stock_on_hand"
    t.date "trans_date"
    t.string "trans_time"
    t.string "trans_document_number"
    t.string "trans_reference_number"
    t.integer "trans_quantity"
    t.float "trans_total_extax_value"
    t.float "trans_total_tax"
    t.float "trans_total_discount_given"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
