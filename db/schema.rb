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

ActiveRecord::Schema.define(version: 20160520140413) do

  create_table "event_issues", force: :cascade do |t|
    t.integer "event_id"
    t.integer "issue_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.date     "event_date"
    t.string   "event_name"
    t.string   "candidate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string "description"
  end

  create_table "shift_skills", force: :cascade do |t|
    t.integer "shift_id"
    t.integer "skill_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.integer  "event_id"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "role"
    t.boolean  "has_limit"
    t.integer  "limit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "skills", force: :cascade do |t|
    t.string "description"
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "shift_id"
    t.integer  "event_id"
    t.integer  "owner_id"
    t.string   "type"
    t.boolean  "read",       default: false
  end

  create_table "user_issues", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "phone_number"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "type",                   default: "User"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "volunteer_commitments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
