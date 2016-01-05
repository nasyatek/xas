# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151217084030) do

  create_table "groups", force: :cascade do |t|
    t.text "name", limit: 65535
    t.boolean "status", limit: 1
    t.integer "index_number", limit: 4
    t.text "note", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "subject", limit: 255
    t.string "body", limit: 255
    t.datetime "attach"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "network_sets", force: :cascade do |t|
    t.string "hostname", limit: 255
    t.string "address", limit: 255
    t.string "netmask", limit: 255
    t.string "network", limit: 255
    t.string "broadcast", limit: 255
    t.string "gateway", limit: 255
    t.string "file_path", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.text "ip", limit: 65535
    t.text "hostname", limit: 65535
    t.boolean "status", limit: 1
    t.text "note", limit: 65535
    t.text "index_number", limit: 65535
    t.integer "group_id", limit: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.text "name", limit: 65535
    t.text "value", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temps", force: :cascade do |t|
    t.decimal "tempc", precision: 4, scale: 2
    t.decimal "tempf", precision: 4, scale: 2
    t.decimal "temph", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mark", limit: 1
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "note", limit: 255
    t.boolean "active", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", limit: 4, default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "xapachi_sets", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "value", limit: 255
    t.string "desc", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xas_sets", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "value", limit: 255
    t.string "desc", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xmail_sets", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "value", limit: 255
    t.string "desc", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xymon_sets", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "value", limit: 255
    t.string "desc", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
