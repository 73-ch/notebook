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

ActiveRecord::Schema.define(version: 20151111140416) do

  create_table "belong_user_to_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_type"
    t.integer  "user_id"
    t.integer  "progress"
    t.string   "color"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "group_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "importance"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "note_type"
    t.string   "site_url"
    t.integer  "category_id"
    t.integer  "group_id"
    t.boolean  "done",        default: false
    t.integer  "progress",    default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invite_groups", force: :cascade do |t|
    t.integer  "invite_user"
    t.integer  "invited_user"
    t.integer  "group_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "importance"
    t.integer  "user_id"
    t.integer  "for_user"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "message_type"
    t.string   "site_urls"
    t.boolean  "done",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "note_processes", force: :cascade do |t|
    t.string   "title"
    t.integer  "note_id"
    t.integer  "user_id"
    t.boolean  "completed",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "importance"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "note_type"
    t.string   "site_url"
    t.integer  "category_id"
    t.integer  "progress",    default: 0
    t.boolean  "done",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
  end

end
