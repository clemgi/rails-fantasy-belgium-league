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

ActiveRecord::Schema.define(version: 20161215151237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "gameweek_squad_players", force: :cascade do |t|
    t.string   "status"
    t.boolean  "captain"
    t.integer  "gameweek"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_id"
    t.integer  "squad_id"
    t.index ["player_id"], name: "index_gameweek_squad_players_on_player_id", using: :btree
    t.index ["squad_id"], name: "index_gameweek_squad_players_on_squad_id", using: :btree
  end

  create_table "gameweeks", force: :cascade do |t|
    t.integer  "gameweek_number"
    t.integer  "lineups"
    t.integer  "minutes_played"
    t.integer  "goal"
    t.integer  "against_goal"
    t.integer  "assist"
    t.integer  "yellow_card"
    t.integer  "red_card"
    t.integer  "day_points"
    t.integer  "player_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "won"
    t.integer  "draw"
    t.integer  "lost"
    t.integer  "gf"
    t.integer  "ga"
    t.integer  "gd"
    t.index ["player_id"], name: "index_gameweeks_on_player_id", using: :btree
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues_users", id: false, force: :cascade do |t|
    t.integer "league_id"
    t.integer "user_id"
    t.index ["league_id"], name: "index_leagues_users_on_league_id", using: :btree
    t.index ["user_id"], name: "index_leagues_users_on_user_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "price"
    t.integer  "team_id"
    t.integer  "total_points"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["team_id"], name: "index_players_on_team_id", using: :btree
  end

  create_table "squad_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "squad_id"
    t.string  "status"
    t.boolean "captain",   default: false, null: false
    t.index ["player_id"], name: "index_squad_players_on_player_id", using: :btree
    t.index ["squad_id"], name: "index_squad_players_on_squad_id", using: :btree
  end

  create_table "squads", force: :cascade do |t|
    t.string   "name"
    t.integer  "budget"
    t.integer  "total_points"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_squads_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "played"
    t.integer  "won"
    t.integer  "draw"
    t.integer  "lost"
    t.integer  "gf"
    t.integer  "ga"
    t.integer  "gd"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "nickname"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                  default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "gameweek_squad_players", "players"
  add_foreign_key "gameweek_squad_players", "squads"
  add_foreign_key "gameweeks", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "squads", "users"
end
