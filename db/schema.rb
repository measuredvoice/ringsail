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

ActiveRecord::Schema.define(version: 20150122183145) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname"
    t.string   "info_url"
    t.string   "mongo_id"
    t.string   "parent_mongo_id"
    t.integer  "parent_id"
  end

  create_table "agency_contacts", force: true do |t|
    t.string   "email"
    t.string   "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agency_contacts", ["agency_id"], name: "index_agency_contacts_on_agency_id", using: :btree

  create_table "auth_tokens", force: true do |t|
    t.string   "token"
    t.string   "email"
    t.string   "phone"
    t.boolean  "admin"
    t.integer  "access_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "duration",     default: "short"
  end

  add_index "auth_tokens", ["email"], name: "index_auth_tokens_on_email", using: :btree
  add_index "auth_tokens", ["token"], name: "index_auth_tokens_on_token", unique: true, using: :btree

  create_table "official_tags", force: true do |t|
    t.string   "shortname"
    t.string   "tag_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "official_tags", ["shortname"], name: "index_official_tags_on_shortname", unique: true, using: :btree

  create_table "outlets", force: true do |t|
    t.string   "service_url"
    t.string   "organization"
    t.string   "info_url"
    t.string   "account"
    t.string   "language"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service"
    t.integer  "location_id"
    t.string   "location_name"
  end

  add_index "outlets", ["account"], name: "index_outlets_on_account", using: :btree
  add_index "outlets", ["service", "account"], name: "index_outlets_on_service_and_account", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "sponsorships", force: true do |t|
    t.integer  "outlet_id"
    t.integer  "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["agency_id"], name: "index_sponsorships_on_agency_id", using: :btree
  add_index "sponsorships", ["outlet_id", "agency_id"], name: "index_sponsorships_on_outlet_id_and_agency_id", unique: true, using: :btree
  add_index "sponsorships", ["outlet_id"], name: "index_sponsorships_on_outlet_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "tagging_unique_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user",                                          null: false
    t.integer  "agency_id"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "groups",              limit: 1000
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
