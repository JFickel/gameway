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

ActiveRecord::Schema.define(version: 20131029183003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliations", force: true do |t|
    t.integer  "affiliate_team_id"
    t.integer  "affiliated_tournament_id"
    t.integer  "affiliated_team_id"
    t.integer  "affiliated_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
    t.string  "token"
    t.string  "token_secret"
  end

  create_table "broadcaster_roles", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "team_id"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_memberships", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "groups", force: true do |t|
    t.string "name"
    t.string "kind"
  end

  create_table "invitations", force: true do |t|
    t.text     "message"
    t.integer  "sender_id"
    t.string   "role"
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moderator_roles", force: true do |t|
    t.integer "tournament_id"
    t.integer "user_id"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "starcraft2_accounts", force: true do |t|
    t.string   "url"
    t.string   "host"
    t.string   "locale"
    t.integer  "realm"
    t.string   "character_name"
    t.integer  "profile_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_memberships", force: true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "team_showings", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.boolean  "top"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  create_table "tournament_memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", force: true do |t|
    t.string   "title"
    t.string   "game"
    t.text     "description"
    t.text     "rules"
    t.datetime "starts_at"
    t.text     "bracket"
    t.integer  "user_id"
    t.text     "mode"
    t.boolean  "started"
    t.boolean  "open"
    t.boolean  "open_applications"
    t.integer  "maximum_participants"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitch_accounts", force: true do |t|
    t.string   "username"
    t.string   "stream_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_showings", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.boolean  "top"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
