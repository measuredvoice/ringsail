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

ActiveRecord::Schema.define(version: 2020_09_23_140249) do

  create_table "activities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "trackable_id"
    t.string "trackable_type"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "key"
    t.text "parameters"
    t.integer "recipient_id"
    t.string "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "admin_services", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "handles_regex_eval"
    t.string "shortname"
    t.string "longname"
    t.string "display_name_eval"
    t.text "account_matchers_eval"
    t.string "service_url_example"
    t.string "service_url_canonical_eval"
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "shortname"
    t.string "info_url"
    t.string "mongo_id"
    t.string "parent_mongo_id"
    t.integer "parent_id"
    t.integer "draft_outlet_count", default: 0
    t.integer "draft_mobile_app_count", default: 0
    t.integer "published_outlet_count", default: 0
    t.integer "published_mobile_app_count", default: 0
    t.integer "draft_gallery_count", default: 0
    t.integer "published_gallery_count", default: 0
    t.integer "api_id"
    t.string "omb_name"
    t.boolean "stats_enabled"
  end

  create_table "auth_tokens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "token"
    t.string "email"
    t.string "phone"
    t.boolean "admin"
    t.integer "access_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "duration", default: "short"
    t.index ["email"], name: "index_auth_tokens_on_email"
    t.index ["token"], name: "index_auth_tokens_on_token", unique: true
  end

  create_table "email_messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.text "to"
    t.string "subject"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "short_description"
    t.text "long_description"
    t.integer "status", default: 0
  end

  create_table "gallery_agencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "gallery_id"
    t.integer "agency_id"
  end

  create_table "gallery_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "gallery_id"
    t.integer "item_id"
    t.string "item_type"
    t.integer "item_order", default: 0
  end

  create_table "gallery_official_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "gallery_id"
    t.integer "official_tag_id"
  end

  create_table "gallery_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "gallery_id"
    t.integer "user_id"
  end

  create_table "government_urls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.string "federal_agency"
    t.string "level_of_government"
    t.string "location"
    t.string "status"
    t.text "note"
    t.string "link"
    t.datetime "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mobile_app_agencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "mobile_app_id"
    t.integer "agency_id"
    t.index ["agency_id"], name: "index_mobile_app_agencies_on_agency_id"
    t.index ["mobile_app_id"], name: "index_mobile_app_agencies_on_mobile_app_id"
  end

  create_table "mobile_app_official_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "mobile_app_id"
    t.integer "official_tag_id"
    t.index ["mobile_app_id"], name: "index_mobile_app_official_tags_on_mobile_app_id"
    t.index ["official_tag_id"], name: "index_mobile_app_official_tags_on_official_tag_id"
  end

  create_table "mobile_app_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "mobile_app_id"
    t.integer "user_id"
    t.index ["mobile_app_id"], name: "index_mobile_app_users_on_mobile_app_id"
    t.index ["user_id"], name: "index_mobile_app_users_on_user_id"
  end

  create_table "mobile_app_versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.integer "mobile_app_id"
    t.text "store_url", limit: 16777215
    t.string "platform"
    t.string "version_number"
    t.datetime "publish_date"
    t.text "description", limit: 16777215
    t.text "whats_new", limit: 16777215
    t.text "screenshot", limit: 16777215
    t.string "device"
    t.string "language"
    t.string "average_rating"
    t.integer "number_of_ratings"
    t.string "mongo_id"
    t.index ["platform"], name: "index_mobile_app_versions_on_platform"
  end

  create_table "mobile_apps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.text "name", limit: 16777215
    t.text "short_description", limit: 16777215
    t.text "long_description", limit: 16777215
    t.text "icon_url", limit: 16777215
    t.string "language"
    t.integer "agency_id"
    t.integer "status", default: 0
    t.string "mongo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "validated_at"
    t.integer "primary_contact_id"
    t.integer "secondary_contact_id"
    t.integer "primary_agency_id"
    t.integer "secondary_agency_id"
    t.text "notes"
  end

  create_table "notifications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.string "item_type"
    t.string "message"
    t.string "message_type"
    t.string "notification_type"
    t.boolean "has_read", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "official_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "tag_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "draft_gallery_count", default: 0
    t.integer "draft_mobile_app_count", default: 0
    t.integer "draft_outlet_count", default: 0
    t.integer "published_gallery_count", default: 0
    t.integer "published_mobile_app_count", default: 0
    t.integer "published_outlet_count", default: 0
    t.integer "tag_type", default: 0
  end

  create_table "outlet_official_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "outlet_id"
    t.integer "official_tag_id"
    t.index ["official_tag_id"], name: "index_outlet_official_tags_on_official_tag_id"
    t.index ["outlet_id"], name: "index_outlet_official_tags_on_outlet_id"
  end

  create_table "outlet_related_policies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "outlet_id"
    t.integer "related_policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outlet_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "outlet_id"
    t.integer "user_id"
    t.index ["outlet_id"], name: "index_outlet_users_on_outlet_id"
    t.index ["user_id"], name: "index_outlet_users_on_user_id"
  end

  create_table "outlets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "service_url"
    t.string "organization"
    t.string "account"
    t.string "language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "service"
    t.integer "status", default: 0
    t.text "short_description", limit: 16777215
    t.text "long_description", limit: 16777215
    t.integer "twitter_followers"
    t.integer "twitter_posts"
    t.integer "twitter_interactions"
    t.integer "facebook_followers"
    t.integer "facebook_likes"
    t.integer "facebook_posts"
    t.integer "facebook_interactions"
    t.integer "youtube_subscribers"
    t.integer "youtube_view_count"
    t.integer "youtube_comment_count"
    t.integer "youtube_video_count"
    t.integer "instagram_followers"
    t.integer "instagram_posts"
    t.string "access_token"
    t.datetime "validated_at"
    t.integer "primary_contact_id"
    t.integer "secondary_contact_id"
    t.integer "primary_agency_id"
    t.integer "secondary_agency_id"
    t.text "notes"
    t.index ["account"], name: "index_outlets_on_account"
    t.index ["service", "account"], name: "index_outlets_on_service_and_account"
    t.index ["service"], name: "index_outlets_on_service"
  end

  create_table "rails_admin_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "message"
    t.string "username"
    t.integer "item"
    t.string "table"
    t.integer "month", limit: 2
    t.bigint "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories"
  end

  create_table "related_policies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "service_wide"
    t.string "service"
    t.string "title"
    t.string "url"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsorships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "outlet_id"
    t.integer "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["agency_id"], name: "index_sponsorships_on_agency_id"
    t.index ["outlet_id", "agency_id"], name: "index_sponsorships_on_outlet_id_and_agency_id", unique: true
    t.index ["outlet_id"], name: "index_sponsorships_on_outlet_id"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context"
    t.datetime "created_at"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "user", null: false
    t.integer "agency_id"
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.text "groups", limit: 16777215
    t.integer "role", default: 0
    t.boolean "agency_notifications", default: false
    t.boolean "agency_notifications_emails", default: false
    t.boolean "contact_notifications", default: true
    t.boolean "contact_notifications_emails", default: true
    t.integer "email_notification_type", default: 0
  end

end
