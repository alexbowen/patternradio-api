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

ActiveRecord::Schema[7.0].define(version: 2023_09_07_140812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "journeys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "travel_area", limit: {:srid=>4055, :type=>"geometry", :geographic=>true}
  end

  create_table "posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.date "published_at"
    t.string "link", null: false
    t.string "guid", null: false
    t.string "author"
    t.string "thumbnail"
    t.string "description"
    t.string "content"
    t.json "enclosure"
    t.json "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "url", null: false
    t.string "name", null: false
    t.datetime "created_time"
    t.datetime "updated_time"
    t.integer "play_count"
    t.integer "favorite_count"
    t.integer "comment_count"
    t.integer "listener_count"
    t.integer "repost_count"
    t.boolean "hidden_stats"
    t.string "slug"
    t.integer "audio_length"
    t.json "pictures"
    t.json "tags"
    t.json "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
