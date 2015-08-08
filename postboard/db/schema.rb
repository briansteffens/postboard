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

ActiveRecord::Schema.define(version: 20150808012731) do

  create_table "boards", force: :cascade do |t|
    t.string   "url_fragment",    limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "password_digest", limit: 255
    t.boolean  "is_listed",                   default: true, null: false
    t.string   "description",     limit: 255
  end

  add_index "boards", ["url_fragment"], name: "index_boards_on_url_fragment", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "board_id",   limit: 4
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "posts", ["board_id"], name: "index_posts_on_board_id", using: :btree

  add_foreign_key "posts", "boards"
end
