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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111209215643) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname"
    t.string   "info_url"
  end

  add_index "agencies", ["shortname"], :name => "index_agencies_on_shortname", :unique => true

  create_table "auth_tokens", :force => true do |t|
    t.string   "token"
    t.string   "email"
    t.string   "phone"
    t.boolean  "admin"
    t.integer  "access_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_tokens", ["email"], :name => "index_auth_tokens_on_email"
  add_index "auth_tokens", ["token"], :name => "index_auth_tokens_on_token", :unique => true

  create_table "official_tags", :force => true do |t|
    t.string   "shortname"
    t.string   "tag_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "official_tags", ["shortname"], :name => "index_official_tags_on_shortname", :unique => true

  create_table "outlets", :force => true do |t|
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

  add_index "outlets", ["account"], :name => "index_outlets_on_account"
  add_index "outlets", ["account"], :name => "index_outlets_on_service_id_and_account", :unique => true
  add_index "outlets", ["service", "account"], :name => "index_outlets_on_service_and_account"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sponsorships", :force => true do |t|
    t.integer  "outlet_id"
    t.integer  "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["agency_id"], :name => "index_sponsorships_on_agency_id"
  add_index "sponsorships", ["outlet_id", "agency_id"], :name => "index_sponsorships_on_outlet_id_and_agency_id", :unique => true
  add_index "sponsorships", ["outlet_id"], :name => "index_sponsorships_on_outlet_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
