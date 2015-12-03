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

ActiveRecord::Schema.define(version: 20151203045511) do

  create_table "chat_direct_images", force: :cascade do |t|
    t.string   "image",               limit: 255, null: false
    t.integer  "sender_id",           limit: 4,   null: false
    t.integer  "chat_direct_room_id", limit: 4,   null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "chat_direct_images", ["chat_direct_room_id"], name: "index_chat_direct_images_on_chat_direct_room_id", using: :btree
  add_index "chat_direct_images", ["sender_id"], name: "index_chat_direct_images_on_sender_id", using: :btree

  create_table "chat_direct_messages", force: :cascade do |t|
    t.text     "message",             limit: 65535, null: false
    t.integer  "sender_id",           limit: 4,     null: false
    t.integer  "chat_direct_room_id", limit: 4,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "chat_direct_messages", ["chat_direct_room_id"], name: "index_chat_direct_messages_on_chat_direct_room_id", using: :btree
  add_index "chat_direct_messages", ["sender_id"], name: "index_chat_direct_messages_on_sender_id", using: :btree

  create_table "chat_direct_room_members", force: :cascade do |t|
    t.integer  "my_user_id",          limit: 4, null: false
    t.integer  "target_user_id",      limit: 4, null: false
    t.integer  "chat_direct_room_id", limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "chat_direct_room_members", ["chat_direct_room_id"], name: "index_chat_direct_room_members_on_chat_direct_room_id", using: :btree
  add_index "chat_direct_room_members", ["my_user_id"], name: "index_chat_direct_room_members_on_my_user_id", using: :btree

  create_table "chat_direct_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_direct_stamps", force: :cascade do |t|
    t.integer  "stamp_id",            limit: 4, null: false
    t.integer  "sender_id",           limit: 4, null: false
    t.integer  "chat_direct_room_id", limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "chat_direct_stamps", ["chat_direct_room_id"], name: "index_chat_direct_stamps_on_chat_direct_room_id", using: :btree
  add_index "chat_direct_stamps", ["sender_id"], name: "index_chat_direct_stamps_on_sender_id", using: :btree

  create_table "chat_direct_unread_caches", force: :cascade do |t|
    t.integer  "chat_direct_room_id", limit: 4,             null: false
    t.integer  "recipient_id",        limit: 4,             null: false
    t.datetime "last_read_at",                              null: false
    t.integer  "unread_count",        limit: 4, default: 0, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "chat_direct_unread_caches", ["chat_direct_room_id"], name: "index_chat_direct_unread_caches_on_chat_direct_room_id", using: :btree
  add_index "chat_direct_unread_caches", ["recipient_id"], name: "index_chat_direct_unread_caches_on_recipient_id", using: :btree

  create_table "chat_direct_with_admin_from_admin_images", force: :cascade do |t|
    t.string   "image",                          limit: 255, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4,   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "chat_direct_with_admin_from_admin_images", ["chat_direct_with_admin_room_id"], name: "direct_with_admin_from_admin_image", using: :btree

  create_table "chat_direct_with_admin_from_admin_messages", force: :cascade do |t|
    t.text     "message",                        limit: 65535, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4,     null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "chat_direct_with_admin_from_admin_messages", ["chat_direct_with_admin_room_id"], name: "direct_admin_message_from_admin", using: :btree

  create_table "chat_direct_with_admin_from_admin_stamps", force: :cascade do |t|
    t.integer  "stamp_id",                       limit: 4, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "chat_direct_with_admin_from_admin_stamps", ["chat_direct_with_admin_room_id"], name: "direct_with_admin_from_admin_stamp", using: :btree

  create_table "chat_direct_with_admin_from_admin_unread_caches", force: :cascade do |t|
    t.integer  "chat_direct_with_admin_room_id", limit: 4,             null: false
    t.integer  "recipient_id",                   limit: 4,             null: false
    t.datetime "last_read_at",                                         null: false
    t.integer  "unread_count",                   limit: 4, default: 0, null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "chat_direct_with_admin_from_admin_unread_caches", ["chat_direct_with_admin_room_id"], name: "chat_direct_with_admin_room_index", using: :btree
  add_index "chat_direct_with_admin_from_admin_unread_caches", ["recipient_id"], name: "chat_direct_with_admin_unread_recipient", using: :btree

  create_table "chat_direct_with_admin_images", force: :cascade do |t|
    t.string   "image",                          limit: 255, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4,   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "chat_direct_with_admin_images", ["chat_direct_with_admin_room_id"], name: "direct_with_admin_image", using: :btree

  create_table "chat_direct_with_admin_messages", force: :cascade do |t|
    t.text     "message",                        limit: 65535, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4,     null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "chat_direct_with_admin_messages", ["chat_direct_with_admin_room_id"], name: "direct_admin_message", using: :btree

  create_table "chat_direct_with_admin_rooms", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "admin_id",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "chat_direct_with_admin_rooms", ["user_id"], name: "index_chat_direct_with_admin_rooms_on_user_id", using: :btree

  create_table "chat_direct_with_admin_stamps", force: :cascade do |t|
    t.integer  "stamp_id",                       limit: 4, null: false
    t.integer  "chat_direct_with_admin_room_id", limit: 4, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "chat_direct_with_admin_stamps", ["chat_direct_with_admin_room_id"], name: "direct_with_admin_stamp", using: :btree

  create_table "chat_room_index_caches", force: :cascade do |t|
    t.string   "name",              limit: 255,                                   null: false
    t.integer  "chat_room_id",      limit: 4,                                     null: false
    t.string   "chat_room_type",    limit: 255,                                   null: false
    t.datetime "last_sent_at",                    default: '2015-12-03 05:45:28'
    t.text     "last_sent_message", limit: 65535
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "chat_room_index_caches", ["chat_room_id"], name: "chattable_id", using: :btree
  add_index "chat_room_index_caches", ["chat_room_type"], name: "chattable_type", using: :btree

  add_foreign_key "chat_direct_images", "chat_direct_rooms"
  add_foreign_key "chat_direct_messages", "chat_direct_rooms"
  add_foreign_key "chat_direct_room_members", "chat_direct_rooms"
  add_foreign_key "chat_direct_stamps", "chat_direct_rooms"
  add_foreign_key "chat_direct_unread_caches", "chat_direct_rooms"
  add_foreign_key "chat_direct_with_admin_from_admin_images", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_from_admin_messages", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_from_admin_stamps", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_from_admin_unread_caches", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_images", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_messages", "chat_direct_with_admin_rooms"
  add_foreign_key "chat_direct_with_admin_stamps", "chat_direct_with_admin_rooms"
end
