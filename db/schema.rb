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

ActiveRecord::Schema.define(version: 20180618181504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_tokens", force: :cascade do |t|
    t.string "name",  limit: 255
    t.string "token", limit: 255
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_tags", force: :cascade do |t|
    t.integer "category_id"
    t.integer "tag_id"
    t.index ["category_id", "tag_id"], name: "index_categories_tags_on_category_id_and_tag_id", using: :btree
    t.index ["category_id"], name: "index_categories_tags_on_category_id", using: :btree
    t.index ["tag_id"], name: "index_categories_tags_on_tag_id", using: :btree
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id",             null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.index ["category_id"], name: "index_category_translations_on_category_id", using: :btree
    t.index ["locale"], name: "index_category_translations_on_locale", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "locale_languages", force: :cascade do |t|
    t.string   "iso_code",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medialinks", force: :cascade do |t|
    t.integer  "profile_id"
    t.text     "url"
    t.text     "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "language",    limit: 255
    t.index ["profile_id"], name: "index_medialinks_on_profile_id", using: :btree
  end

  create_table "profile_translations", force: :cascade do |t|
    t.integer  "profile_id",             null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "main_topic", limit: 255
    t.text     "bio"
    t.string   "twitter",    limit: 255
    t.string   "website",    limit: 255
    t.string   "city",       limit: 255
    t.string   "website_2"
    t.string   "website_3"
    t.index ["locale"], name: "index_profile_translations_on_locale", using: :btree
    t.index ["profile_id"], name: "index_profile_translations_on_profile_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "email",                  limit: 255
    t.string   "languages",              limit: 255
    t.string   "picture",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "talks",                  limit: 255
    t.boolean  "admin",                              default: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "media_url",              limit: 255
    t.boolean  "published",                          default: false
    t.text     "admin_comment"
    t.string   "slug",                   limit: 255
    t.string   "country",                limit: 255
    t.string   "iso_languages",          limit: 255
    t.index ["confirmation_token"], name: "index_profiles_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_profiles_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_profiles_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_profiles_on_slug", unique: true, using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tags_locale_languages", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "locale_language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
