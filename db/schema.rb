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

ActiveRecord::Schema.define(version: 20180418030403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "zip"
    t.string "state"
    t.string "city"
    t.string "apt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "clinic_id"
    t.bigint "insurance_id"
    t.index ["clinic_id"], name: "index_addresses_on_clinic_id"
    t.index ["insurance_id"], name: "index_addresses_on_insurance_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.index ["address_id"], name: "index_clinics_on_address_id"
    t.index ["authentication_token"], name: "index_clinics_on_authentication_token", unique: true
    t.index ["phone"], name: "index_clinics_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_clinics_on_reset_password_token", unique: true
  end

  create_table "clinics_records", force: :cascade do |t|
    t.bigint "clinic_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_id"], name: "index_clinics_records_on_clinic_id"
    t.index ["record_id"], name: "index_clinics_records_on_record_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.string "phone"
    t.string "name"
    t.string "email"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.index ["address_id"], name: "index_insurances_on_address_id"
    t.index ["authentication_token"], name: "index_insurances_on_authentication_token", unique: true
    t.index ["phone"], name: "index_insurances_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_insurances_on_reset_password_token", unique: true
  end

  create_table "policies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "insurance_id"
    t.string "policy_number"
    t.bigint "policy_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_id"], name: "index_policies_on_insurance_id"
    t.index ["policy_group_id"], name: "index_policies_on_policy_group_id"
    t.index ["user_id"], name: "index_policies_on_user_id"
  end

  create_table "policy_groups", force: :cascade do |t|
    t.string "group_number"
    t.bigint "insurance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_id"], name: "index_policy_groups_on_insurance_id"
  end

  create_table "record_types", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_record_types_on_parent_id"
  end

  create_table "record_types_records", force: :cascade do |t|
    t.bigint "record_id"
    t.bigint "record_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_record_types_records_on_record_id"
    t.index ["record_type_id"], name: "index_record_types_records_on_record_type_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "clinic_id"
    t.string "name"
    t.string "mime_type"
    t.integer "file_size"
    t.index ["clinic_id"], name: "index_records_on_clinic_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "share_requests", force: :cascade do |t|
    t.integer "status"
    t.bigint "user_id"
    t.bigint "clinic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", null: false
    t.boolean "is_patient"
    t.string "legal_rep_name"
    t.string "legal_rep_relation"
    t.index ["clinic_id"], name: "index_share_requests_on_clinic_id"
    t.index ["user_id"], name: "index_share_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "social"
    t.string "email"
    t.string "phone"
    t.date "birth_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.bigint "insurance_id"
    t.string "insurance_unique_id"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.string "last_name", null: false
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["insurance_id"], name: "index_users_on_insurance_id"
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["social"], name: "index_users_on_social", unique: true
  end

  create_table "validations", force: :cascade do |t|
    t.datetime "expiration"
    t.bigint "user_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_validations_on_user_id"
  end

  add_foreign_key "addresses", "clinics"
  add_foreign_key "addresses", "insurances"
  add_foreign_key "addresses", "users"
  add_foreign_key "clinics", "addresses"
  add_foreign_key "clinics_records", "clinics"
  add_foreign_key "clinics_records", "records"
  add_foreign_key "insurances", "addresses"
  add_foreign_key "policies", "insurances"
  add_foreign_key "policies", "policy_groups"
  add_foreign_key "policies", "users"
  add_foreign_key "policy_groups", "insurances"
  add_foreign_key "record_types_records", "record_types"
  add_foreign_key "record_types_records", "records"
  add_foreign_key "records", "clinics"
  add_foreign_key "records", "users"
  add_foreign_key "share_requests", "clinics"
  add_foreign_key "share_requests", "users"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "insurances"
  add_foreign_key "validations", "users"
end
