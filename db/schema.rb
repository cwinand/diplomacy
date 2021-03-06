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

ActiveRecord::Schema.define(version: 2019_09_30_183559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", id: false, force: :cascade do |t|
    t.string "country_code", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_code"], name: "index_countries_on_country_code", unique: true
  end

  create_table "game_countries", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "country_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["game_id"], name: "index_game_countries_on_game_id"
    t.index ["user_id"], name: "index_game_countries_on_user_id"
  end

  create_table "game_players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pending"
    t.boolean "confirmed"
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["user_id"], name: "index_game_players_on_user_id"
  end

  create_table "game_provinces", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "province_code", null: false
    t.string "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_provinces_on_game_id"
  end

  create_table "game_settings", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "turn_length"
    t.string "assignment_strategy"
    t.boolean "allow_illegal_moves"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "weekend_skip"
    t.index ["game_id"], name: "index_game_settings_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "start"
    t.string "end"
    t.string "order_type"
    t.string "end_coast"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "turn_id", null: false
    t.bigint "game_country_id", null: false
    t.bigint "unit_id"
    t.string "support_start"
    t.string "support_end"
    t.string "support_order_type"
    t.string "support_order_unit_type"
    t.index ["game_country_id"], name: "index_orders_on_game_country_id"
    t.index ["turn_id"], name: "index_orders_on_turn_id"
    t.index ["unit_id"], name: "index_orders_on_unit_id"
  end

  create_table "province_borders", force: :cascade do |t|
    t.string "province_code"
    t.string "border_province_code"
    t.string "border_coastal_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provinces", id: false, force: :cascade do |t|
    t.string "province_code", null: false
    t.string "name"
    t.boolean "is_sc"
    t.string "coast_1"
    t.string "coast_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "province_type"
    t.string "home_of"
    t.index ["province_code"], name: "index_provinces_on_province_code", unique: true
  end

  create_table "turns", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "season"
    t.integer "year"
    t.datetime "expiration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_turns_on_game_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "unit_type"
    t.string "current_province"
    t.bigint "game_country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "coast"
    t.index ["game_country_id"], name: "index_units_on_game_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "game_countries", "games"
  add_foreign_key "game_countries", "users"
  add_foreign_key "game_players", "games"
  add_foreign_key "game_provinces", "games"
  add_foreign_key "game_settings", "games"
  add_foreign_key "games", "users"
  add_foreign_key "orders", "game_countries"
  add_foreign_key "turns", "games"
  add_foreign_key "units", "game_countries"
end
