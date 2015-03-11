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

ActiveRecord::Schema.define(version: 20150310144904) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "agencies", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname",                  limit: 255
    t.string   "info_url",                   limit: 255
    t.string   "mongo_id",                   limit: 255
    t.string   "parent_mongo_id",            limit: 255
    t.integer  "parent_id",                  limit: 4
    t.integer  "draft_outlet_count",         limit: 4,   default: 0
    t.integer  "draft_mobile_app_count",     limit: 4,   default: 0
    t.integer  "published_outlet_count",     limit: 4,   default: 0
    t.integer  "published_mobile_app_count", limit: 4,   default: 0
    t.integer  "draft_gallery_count",        limit: 4,   default: 0
    t.integer  "published_gallery_count",    limit: 4,   default: 0
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "token",        limit: 255
    t.string   "email",        limit: 255
    t.string   "phone",        limit: 255
    t.boolean  "admin",        limit: 1
    t.integer  "access_count", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "duration",     limit: 255, default: "short"
  end

  add_index "auth_tokens", ["email"], name: "index_auth_tokens_on_email", using: :btree
  add_index "auth_tokens", ["token"], name: "index_auth_tokens_on_token", unique: true, using: :btree

  create_table "email_messages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "to",         limit: 255
    t.string   "subject",    limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_id",          limit: 4
    t.text     "short_description", limit: 65535
    t.text     "long_description",  limit: 65535
    t.integer  "status",            limit: 4
  end

  create_table "gallery_agencies", force: :cascade do |t|
    t.integer "gallery_id", limit: 4
    t.integer "agency_id",  limit: 4
  end

  create_table "gallery_items", force: :cascade do |t|
    t.integer "gallery_id", limit: 4
    t.integer "item_id",    limit: 4
    t.string  "item_type",  limit: 255
    t.integer "item_order", limit: 4,   default: 0
  end

  create_table "gallery_official_tags", force: :cascade do |t|
    t.integer "gallery_id",      limit: 4
    t.integer "official_tag_id", limit: 4
  end

  create_table "gallery_users", force: :cascade do |t|
    t.integer "gallery_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  create_table "mobile_app_agencies", force: :cascade do |t|
    t.integer "mobile_app_id", limit: 4
    t.integer "agency_id",     limit: 4
  end

  create_table "mobile_app_official_tags", force: :cascade do |t|
    t.integer "mobile_app_id",   limit: 4
    t.integer "official_tag_id", limit: 4
  end

  create_table "mobile_app_users", force: :cascade do |t|
    t.integer "mobile_app_id", limit: 4
    t.integer "user_id",       limit: 4
  end

  create_table "mobile_app_versions", force: :cascade do |t|
    t.integer  "mobile_app_id",     limit: 4
    t.string   "store_url",         limit: 255
    t.string   "platform",          limit: 255
    t.string   "version_number",    limit: 255
    t.datetime "publish_date"
    t.text     "description",       limit: 65535
    t.text     "whats_new",         limit: 65535
    t.text     "screenshot",        limit: 65535
    t.string   "device",            limit: 255
    t.string   "language",          limit: 255
    t.string   "average_rating",    limit: 255
    t.integer  "number_of_ratings", limit: 4
    t.string   "mongo_id",          limit: 255
  end

  create_table "mobile_apps", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "short_description", limit: 65535
    t.text     "long_description",  limit: 65535
    t.string   "icon_url",          limit: 255
    t.string   "language",          limit: 255
    t.integer  "agency_id",         limit: 4
    t.integer  "status",            limit: 4,     default: 0
    t.string   "mongo_id",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_id",          limit: 4
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "item_id",           limit: 4
    t.string   "item_type",         limit: 255
    t.string   "message",           limit: 255
    t.string   "message_type",      limit: 255
    t.string   "notification_type", limit: 255
    t.boolean  "has_read",          limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "official_tags", force: :cascade do |t|
    t.string   "tag_text",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_gallery_count",        limit: 4,   default: 0
    t.integer  "draft_mobile_app_count",     limit: 4,   default: 0
    t.integer  "draft_outlet_count",         limit: 4,   default: 0
    t.integer  "published_gallery_count",    limit: 4,   default: 0
    t.integer  "published_mobile_app_count", limit: 4,   default: 0
    t.integer  "published_outlet_count",     limit: 4,   default: 0
    t.integer  "tag_type",                   limit: 4,   default: 0
  end

  create_table "outlet_bulk_uploads", force: :cascade do |t|
    t.string   "filename",     limit: 255
    t.string   "content_type", limit: 255
    t.binary   "data",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "outlet_official_tags", force: :cascade do |t|
    t.integer "outlet_id",       limit: 4
    t.integer "official_tag_id", limit: 4
  end

  create_table "outlet_users", force: :cascade do |t|
    t.integer "outlet_id", limit: 4
    t.integer "user_id",   limit: 4
  end

  create_table "outlets", force: :cascade do |t|
    t.string   "service_url",       limit: 255
    t.string   "organization",      limit: 255
    t.string   "account",           limit: 255
    t.string   "language",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service",           limit: 255
    t.integer  "status",            limit: 4,     default: 0
    t.integer  "draft_id",          limit: 4
    t.text     "short_description", limit: 65535
    t.text     "long_description",  limit: 65535
  end

  add_index "outlets", ["account"], name: "index_outlets_on_account", using: :btree
  add_index "outlets", ["service", "account"], name: "index_outlets_on_service_and_account", using: :btree

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message",    limit: 65535
    t.string   "username",   limit: 255
    t.integer  "item",       limit: 4
    t.string   "table",      limit: 255
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "sponsorships", force: :cascade do |t|
    t.integer  "outlet_id",  limit: 4
    t.integer  "agency_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["agency_id"], name: "index_sponsorships_on_agency_id", using: :btree
  add_index "sponsorships", ["outlet_id", "agency_id"], name: "index_sponsorships_on_outlet_id_and_agency_id", unique: true, using: :btree
  add_index "sponsorships", ["outlet_id"], name: "index_sponsorships_on_outlet_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 255
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                        limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                limit: 4
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user",                         limit: 255,                   null: false
    t.integer  "agency_id",                    limit: 4
    t.string   "phone",                        limit: 255
    t.string   "first_name",                   limit: 255
    t.string   "last_name",                    limit: 255
    t.text     "groups",                       limit: 65535
    t.integer  "role",                         limit: 4,     default: 0
    t.boolean  "agency_notifications",         limit: 1,     default: false
    t.boolean  "agency_notifications_emails",  limit: 1,     default: false
    t.boolean  "contact_notifications",        limit: 1,     default: true
    t.boolean  "contact_notifications_emails", limit: 1,     default: true
    t.integer  "email_notification_type",      limit: 4,     default: 0
  end

end
