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

ActiveRecord::Schema.define(version: 20170729153634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "static_player_stats", force: :cascade do |t|
    t.bigint "static_player_id"
    t.string "season"
    t.string "team"
    t.integer "games_played"
    t.integer "games_started"
    t.decimal "minutes_per_game", precision: 3, scale: 1
    t.decimal "field_goal_percent", precision: 3, scale: 3
    t.decimal "three_point_percent", precision: 3, scale: 3
    t.decimal "free_throw_percent", precision: 3, scale: 3
    t.decimal "rebounds_per_game", precision: 3, scale: 1
    t.decimal "assists_per_game", precision: 3, scale: 1
    t.decimal "steals_per_game", precision: 3, scale: 1
    t.decimal "blocks_per_game", precision: 3, scale: 1
    t.decimal "points_per_game", precision: 3, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["static_player_id"], name: "index_static_player_stats_on_static_player_id"
  end

  create_table "static_players", force: :cascade do |t|
    t.bigint "static_team_id"
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
    t.datetime "age"
    t.datetime "birth_date"
    t.string "which_pick"
    t.integer "years_pro"
    t.integer "status", default: 0
    t.string "wiki_link"
    t.string "image_link"
    t.string "from_city"
    t.index ["static_team_id"], name: "index_static_players_on_static_team_id"
  end

  create_table "static_teams", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "static_player_stats", "static_players"
  add_foreign_key "static_players", "static_teams"
end
