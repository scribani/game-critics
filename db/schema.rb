# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_20_022114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "critics", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.string "criticable_type", null: false
    t.bigint "criticable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["criticable_type", "criticable_id"], name: "index_critics_on_criticable"
    t.index ["user_id"], name: "index_critics_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.text "summary"
    t.date "release_date"
    t.integer "category", default: 0
    t.decimal "rating", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.index ["name"], name: "index_games_on_name", unique: true
    t.index ["parent_id"], name: "index_games_on_parent_id"
  end

  create_table "games_genres", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "genre_id", null: false
    t.index ["game_id", "genre_id"], name: "index_games_genres_on_game_id_and_genre_id"
    t.index ["genre_id", "game_id"], name: "index_games_genres_on_genre_id_and_game_id"
  end

  create_table "games_platfoms", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "platfom_id", null: false
    t.index ["game_id", "platfom_id"], name: "index_games_platfoms_on_game_id_and_platfom_id"
    t.index ["platfom_id", "game_id"], name: "index_games_platfoms_on_platfom_id_and_game_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "involved_companies", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "game_id", null: false
    t.boolean "developer"
    t.boolean "publisher"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id", "game_id"], name: "index_involved_companies_on_company_id_and_game_id", unique: true
    t.index ["company_id"], name: "index_involved_companies_on_company_id"
    t.index ["game_id"], name: "index_involved_companies_on_game_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_platforms_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "role", default: 0
    t.integer "critics_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "critics", "users"
  add_foreign_key "games", "games", column: "parent_id"
  add_foreign_key "involved_companies", "companies"
  add_foreign_key "involved_companies", "games"
end
