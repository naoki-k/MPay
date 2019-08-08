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

ActiveRecord::Schema.define(version: 2019_08_08_023038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.integer "amount", null: false
    t.string "content", limit: 3000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_billings_on_receiver_id"
    t.index ["sender_id"], name: "index_billings_on_sender_id"
  end

  create_table "corporate_informations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address", limit: 255, null: false
    t.string "detail", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_corporate_informations_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "kind", limit: 25, null: false
    t.string "number", limit: 255, null: false
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "following_user_id", null: false
    t.bigint "followed_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_user_id"], name: "index_relationships_on_followed_user_id"
    t.index ["following_user_id"], name: "index_relationships_on_following_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "active_payment_id", null: false
    t.bigint "passive_payment_id", null: false
    t.bigint "billing_id"
    t.string "kind", limit: 25, null: false
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.index ["active_payment_id"], name: "index_trades_on_active_payment_id"
    t.index ["billing_id"], name: "index_trades_on_billing_id"
    t.index ["passive_payment_id"], name: "index_trades_on_passive_payment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", limit: 25, default: "0", null: false
    t.string "tel", limit: 25, null: false
    t.string "name", limit: 25, null: false
    t.string "email", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tel"], name: "index_users_on_tel", unique: true
    t.index ["type"], name: "index_users_on_type"
  end

  add_foreign_key "billings", "users", column: "receiver_id"
  add_foreign_key "billings", "users", column: "sender_id"
  add_foreign_key "corporate_informations", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "relationships", "users", column: "followed_user_id"
  add_foreign_key "relationships", "users", column: "following_user_id"
  add_foreign_key "trades", "billings"
  add_foreign_key "trades", "payments", column: "active_payment_id"
  add_foreign_key "trades", "payments", column: "passive_payment_id"
end
