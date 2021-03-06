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

ActiveRecord::Schema.define(version: 2021_07_30_071457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_times", force: :cascade do |t|
    t.bigint "movie_id"
    t.time "show_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_times_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "omdb_id", null: false
    t.boolean "omdb_synced", default: false, null: false
    t.string "title"
    t.text "description"
    t.decimal "imdb_rating", precision: 3, scale: 1
    t.date "released_at"
    t.string "runtime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 6, scale: 2, default: "10.0", null: false
  end

  add_foreign_key "movie_times", "movies"
end
