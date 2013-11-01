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

ActiveRecord::Schema.define(version: 20131101212819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_sources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "href"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_source_id"
    t.string   "image_src_file_name"
    t.string   "image_src_content_type"
    t.integer  "image_src_file_size"
    t.datetime "image_src_updated_at"
    t.integer  "index_in_feed"
  end

  add_index "posts", ["created_at", "index_in_feed"], name: "index_posts_on_created_at_and_index_in_feed", order: {"created_at"=>:desc}, using: :btree
  add_index "posts", ["feed_source_id"], name: "index_posts_on_feed_source_id", using: :btree
  add_index "posts", ["href"], name: "index_posts_on_href", unique: true, using: :btree

end
