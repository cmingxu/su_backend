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

ActiveRecord::Schema.define(version: 20150724010836) do

  create_table "entities", force: :cascade do |t|
    t.integer  "folder_id",   limit: 4
    t.string   "name",        limit: 255
    t.string   "skp_file",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id",     limit: 4
    t.text     "description", limit: 65535
    t.string   "icon",        limit: 255
    t.string   "uuid",        limit: 255
    t.boolean  "is_system",   limit: 1,     default: false
    t.boolean  "visible",     limit: 1,     default: true
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "entity_count", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id",      limit: 4
    t.string   "uuid",         limit: 255
    t.boolean  "is_system",    limit: 1,   default: false
  end

  create_table "kindeditor_assets", force: :cascade do |t|
    t.string   "asset",      limit: 255
    t.integer  "file_size",  limit: 4
    t.string   "file_type",  limit: 255
    t.integer  "owner_id",   limit: 4
    t.string   "asset_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "vendor_id",  limit: 4
    t.string   "icon",       limit: 255
    t.decimal  "price",                  precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "uuid",       limit: 255
    t.string   "code",       limit: 255
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                   limit: 255
    t.string   "roles",                  limit: 255
    t.boolean  "visible",                limit: 1,   default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "tel",        limit: 255
    t.string   "address",    limit: 255
    t.text     "short_desc", limit: 65535
    t.text     "desc",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "uuid",       limit: 255
  end

end
