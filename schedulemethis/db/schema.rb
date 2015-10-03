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

ActiveRecord::Schema.define(version: 20151002234851) do

  create_table "event_instances", force: :cascade do |t|
    t.integer  "event_id"
    t.boolean  "completed"
    t.boolean  "dismissed"
    t.datetime "scheduled_start"
    t.datetime "scheduled_end"
    t.string   "location"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "event_instances", ["event_id"], name: "index_event_instances_on_event_id"

  create_table "event_recurrences", force: :cascade do |t|
    t.integer  "event_id"
    t.boolean  "even_weeks"
    t.boolean  "odd_weeks"
    t.boolean  "yearly"
    t.string   "months"
    t.string   "days"
    t.boolean  "auto_dismiss"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "event_recurrences", ["event_id"], name: "index_event_recurrences_on_event_id"

  create_table "events", force: :cascade do |t|
    t.string   "short_description"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "start_time_flex_amount"
    t.integer  "end_time_flex_amount"
    t.integer  "priority"
    t.boolean  "may_split"
    t.integer  "estimated_time_required"
    t.string   "location"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "user_from_id"
    t.integer  "user_to_id"
    t.boolean  "pending"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "friends", ["user_to_id"], name: "index_friends_on_user_to_id"

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
