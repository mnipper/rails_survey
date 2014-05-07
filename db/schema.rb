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

ActiveRecord::Schema.define(version: 20140313161034) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  add_index "devices", ["identifier"], name: "index_devices_on_identifier", unique: true

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "question_id"
  end

  create_table "instrument_translations", force: true do |t|
    t.integer  "instrument_id"
    t.string   "language"
    t.string   "alignment"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
    t.string   "alignment"
    t.integer  "child_update_count",      default: 0
    t.integer  "previous_question_count"
    t.integer  "project_id"
    t.boolean  "published"
    t.datetime "deleted_at"
  end

  create_table "option_translations", force: true do |t|
    t.integer  "option_id"
    t.text     "text"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "next_question"
    t.integer  "number_in_question"
    t.datetime "deleted_at"
  end

  create_table "project_devices", force: true do |t|
    t.integer  "project_id"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_translations", force: true do |t|
    t.integer  "question_id"
    t.string   "language"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reg_ex_validation_message"
  end

  create_table "questions", force: true do |t|
    t.text     "text"
    t.string   "question_type"
    t.string   "question_identifier"
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "following_up_question_identifier"
    t.string   "reg_ex_validation"
    t.integer  "number_in_instrument"
    t.string   "reg_ex_validation_message"
    t.datetime "deleted_at"
    t.integer  "follow_up_position",               default: 0
    t.boolean  "identifies_survey",                default: false
  end

  add_index "questions", ["question_identifier"], name: "index_questions_on_question_identifier", unique: true

  create_table "response_images", force: true do |t|
    t.string   "response_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "responses", force: true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.string   "other_response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "survey_uuid"
    t.string   "special_response"
    t.datetime "time_started"
    t.datetime "time_ended"
    t.string   "question_identifier"
<<<<<<< HEAD
  end

=======
    t.string   "uuid"
  end

  add_index "responses", ["uuid"], name: "index_responses_on_uuid"

>>>>>>> 298b47b660e3806d4983eff2320157e69aaf2e2a
  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
=======
    t.integer  "user_id"
>>>>>>> 298b47b660e3806d4983eff2320157e69aaf2e2a
  end

  create_table "surveys", force: true do |t|
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
    t.integer  "device_id"
    t.integer  "instrument_version_number"
    t.string   "instrument_title"
    t.string   "device_uuid"
    t.string   "latitude"
    t.string   "longitude"
  end

  add_index "surveys", ["uuid"], name: "index_surveys_on_uuid"

  create_table "user_projects", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
