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

ActiveRecord::Schema.define(:version => 20111110004905) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname"
  end

  add_index "agencies", ["shortname"], :name => "index_agencies_on_shortname", :unique => true

  create_table "outlets", :force => true do |t|
    t.string   "service_url"
    t.string   "organization"
    t.string   "info_url"
    t.string   "account"
    t.string   "language"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
  end

  add_index "outlets", ["account"], :name => "index_outlets_on_account"
  add_index "outlets", ["service_id", "account"], :name => "index_outlets_on_service_id_and_account", :unique => true
  add_index "outlets", ["service_id"], :name => "index_outlets_on_service_id"

  create_table "services", :force => true do |t|
    t.string   "shortname"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["shortname"], :name => "index_services_on_shortname", :unique => true

  create_table "sponsorships", :force => true do |t|
    t.integer  "outlet_id"
    t.integer  "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["agency_id"], :name => "index_sponsorships_on_agency_id"
  add_index "sponsorships", ["outlet_id", "agency_id"], :name => "index_sponsorships_on_outlet_id_and_agency_id", :unique => true
  add_index "sponsorships", ["outlet_id"], :name => "index_sponsorships_on_outlet_id"

end
