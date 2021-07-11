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

ActiveRecord::Schema.define(version: 20210710152632) do

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "account_number", null: false
    t.float "amount", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bank_account_id"
    t.string "nick_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_account_id"], name: "index_beneficiaries_on_bank_account_id"
    t.index ["user_id"], name: "index_beneficiaries_on_user_id"
  end

  create_table "one_time_passwords", force: :cascade do |t|
    t.integer "user_id"
    t.string "encrypted_otp", null: false
    t.datetime "expired_at"
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_one_time_passwords_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "beneficiary_id"
    t.integer "sender_account_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_id"], name: "index_transactions_on_beneficiary_id"
    t.index ["sender_account_id"], name: "index_transactions_on_sender_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
