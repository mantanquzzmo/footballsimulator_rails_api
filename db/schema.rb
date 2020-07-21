# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_21_232951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "season_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "games_teams", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "team_id", null: false
    t.index ["game_id", "team_id"], name: "index_games_teams_on_game_id_and_team_id"
    t.index ["team_id", "game_id"], name: "index_games_teams_on_team_id_and_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age", null: false
    t.string "position", null: false
    t.float "skill", null: false
    t.integer "form", null: false
    t.integer "form_tendency", null: false
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons_teams", id: false, force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "team_id", null: false
    t.index ["season_id", "team_id"], name: "index_seasons_teams_on_season_id_and_team_id"
    t.index ["team_id", "season_id"], name: "index_seasons_teams_on_team_id_and_season_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "primary_color"
    t.string "secondary_color"
    t.integer "balance", default: 100
    t.bigint "user_id"
    t.boolean "cpu_team", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.integer "form_before", null: false
    t.integer "form_after", null: false
    t.integer "form_tendency_before", null: false
    t.integer "form_tendency_after", null: false
    t.bigint "player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_trainings_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: true
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "games", "seasons"
  add_foreign_key "players", "teams"
  add_foreign_key "teams", "users"
  add_foreign_key "trainings", "players"
end
