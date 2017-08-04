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

ActiveRecord::Schema.define(version: 20170804184541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "league_players", force: :cascade do |t|
    t.integer "league_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_team_id"
    t.index ["league_id", "player_id"], name: "index_league_players_on_league_id_and_player_id", unique: true
  end

  create_table "league_teams", force: :cascade do |t|
    t.integer "league_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "commissioner"
    t.string "headquarters"
    t.string "inaugural_season"
    t.integer "number_of_teams"
    t.string "abbreviation"
  end

  create_table "leagues_users", id: false, force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "user_id", null: false
    t.index ["league_id", "user_id"], name: "index_leagues_users_on_league_id_and_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "jersey_number"
    t.integer "height"
    t.integer "weight"
    t.string "before_nba"
    t.boolean "is_rookie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.datetime "birth_date"
    t.string "which_pick"
    t.integer "years_pro"
    t.integer "status", default: 0
    t.string "wiki_link"
    t.string "image_link"
    t.string "from_city"
  end

  create_table "stats", force: :cascade do |t|
    t.bigint "league_player_id"
    t.bigint "league_team_id"
    t.string "season"
    t.string "team"
    t.integer "games_played"
    t.integer "games_started"
    t.decimal "minutes_per_game", precision: 3, scale: 1
    t.decimal "field_goal_percent", precision: 4, scale: 3
    t.decimal "three_point_percent", precision: 4, scale: 3
    t.decimal "free_throw_percent", precision: 4, scale: 3
    t.decimal "rebounds_per_game", precision: 3, scale: 1
    t.decimal "assists_per_game", precision: 3, scale: 1
    t.decimal "steals_per_game", precision: 3, scale: 1
    t.decimal "blocks_per_game", precision: 3, scale: 1
    t.decimal "points_per_game", precision: 3, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category"
    t.integer "level"
    t.index ["league_player_id"], name: "index_stats_on_league_player_id"
    t.index ["league_team_id"], name: "index_stats_on_league_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "last_name"
    t.string "first_name"
    t.string "username", limit: 25
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "stats", "league_players"
  add_foreign_key "stats", "league_teams"
end
