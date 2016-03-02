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

ActiveRecord::Schema.define(version: 20160302191134) do

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description"
    t.string   "location"
    t.datetime "event_date"
    t.string   "event_name"
    t.string   "candidate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "role"
    t.boolean  "has_limit"
    t.integer  "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "skills"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "volunteer_commitments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
