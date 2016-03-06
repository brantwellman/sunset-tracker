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

ActiveRecord::Schema.define(version: 20160306220640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecasts", force: :cascade do |t|
    t.float    "cloud_cover"
    t.float    "precip_prob"
    t.float    "visibility"
    t.float    "precip_intensity"
    t.float    "ozone"
    t.integer  "location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "summary"
    t.datetime "sunrise"
    t.datetime "sunset"
    t.string   "timezone"
  end

  add_index "forecasts", ["location_id"], name: "index_forecasts_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.integer  "favorite",   default: 0
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "secret"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
  end

  add_foreign_key "forecasts", "locations"
  add_foreign_key "locations", "users"
end
