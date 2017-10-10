# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171010185525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "number"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_with_attributes", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "product_atrs_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["card_id", "product_atrs_id"], name: "index_card_with_attributes_on_card_id_and_product_atrs_id", unique: true, using: :btree
  end

  create_table "cards", force: :cascade do |t|
    t.string   "card_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.string   "friendly_url"
    t.integer  "parent_id",        default: 0
    t.boolean  "view_main"
    t.string   "category_content"
    t.string   "image"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "status_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_status_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "status_user_id"
  end

  create_table "product_with_attributes", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "product_atrs_id"
    t.string   "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["product_id", "product_atrs_id"], name: "index_product_with_attributes_on_product_id_and_product_atrs_id", unique: true, using: :btree
  end

  create_table "productatrs", force: :cascade do |t|
    t.string   "attribute_name"
    t.string   "attribute_rus_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "friendly_url"
    t.integer  "category_id",   default: 0
    t.string   "product_title"
    t.boolean  "view_main"
    t.string   "image"
    t.integer  "price"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "status_users", force: :cascade do |t|
    t.string   "user_status_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "unknown_users", force: :cascade do |t|
    t.string   "unknown_user_name"
    t.string   "email"
    t.bigint   "telephone"
    t.string   "unknown_remember_token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["unknown_remember_token"], name: "index_unknown_users_on_unknown_remember_token", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "surname"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "confirm_token"
    t.boolean  "email_confirmed", default: false
    t.string   "reset_password"
    t.datetime "reset_sent_at"
    t.boolean  "status",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
