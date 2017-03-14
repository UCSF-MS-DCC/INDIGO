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

ActiveRecord::Schema.define(version: 20170314173519) do

  create_table "batches", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "source"
    t.string   "disease"
    t.string   "samples_received_at_ucsf"
    t.string   "samples_sent_to_stanford"
    t.integer  "hlas_available"
    t.integer  "kirs_available"
    t.integer  "dataset_id"
    t.index ["dataset_id"], name: "index_batches_on_dataset_id"
  end

  create_table "datasets", force: :cascade do |t|
    t.string   "source"
    t.integer  "expected_discovery"
    t.string   "disease"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "hlas", force: :cascade do |t|
    t.string   "indigo_id"
    t.string   "drb1_15_copies_calculated"
    t.string   "drb1_1"
    t.string   "drb1_2"
    t.string   "dqb1_1"
    t.string   "dqb1_2"
    t.string   "dpb1_1"
    t.string   "dpb1_2"
    t.string   "a_1"
    t.string   "a_2"
    t.string   "b_1"
    t.string   "b_2"
    t.string   "c_1"
    t.string   "c_2"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "sample_id"
    t.string   "dpa1_1"
    t.string   "dpa1_2"
    t.string   "dqa1_1"
    t.string   "dqa1_2"
    t.string   "drbo_1"
    t.string   "drbo_2"
    t.string   "dpb1_phase_ambiguities"
    t.index ["sample_id"], name: "index_hlas_on_sample_id"
  end

  create_table "hlauploads", force: :cascade do |t|
    t.string   "datafile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "idrs", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "indigo_id"
    t.string   "sample_source"
    t.string   "disease"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "batch"
    t.integer  "age_at_sample"
    t.string   "race"
    t.string   "received_date"
    t.string   "sent_date"
    t.string   "drb1_15_copies_calculated"
    t.string   "drb1_1"
    t.string   "drb1_2"
    t.string   "dqb1_1"
    t.string   "dqb1_2"
    t.string   "dpb1_1"
    t.string   "dpb1_2"
    t.string   "a_1"
    t.string   "a_2"
    t.string   "b_1"
    t.string   "b_2"
    t.string   "c_1"
    t.string   "c_2"
    t.string   "dpa1_1"
    t.string   "dpa1_2"
    t.string   "dqa1_1"
    t.string   "dqa1_2"
    t.string   "drbo_1"
    t.string   "drbo_2"
    t.string   "site_sample_id"
    t.string   "dpb1_phase_ambiguities"
  end

  create_table "keys", force: :cascade do |t|
    t.string   "keyfile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kirs", force: :cascade do |t|
    t.string   "indigo_id"
    t.string   "i2dl1"
    t.string   "x2dl1_2"
    t.string   "i2dl2"
    t.string   "x2dl2_2"
    t.string   "i2dl3"
    t.string   "x2dl3_2"
    t.string   "i2dl4"
    t.string   "x2dl4_2"
    t.string   "i2dl5a"
    t.string   "i2dl5a_2"
    t.string   "i2dl5b"
    t.string   "i2dl5b_2"
    t.string   "i2dp1"
    t.string   "x2dp1_2"
    t.string   "i2ds1"
    t.string   "x2ds1_2"
    t.string   "i2ds2"
    t.string   "x2ds2_2"
    t.string   "i2ds3"
    t.string   "x2ds3_2"
    t.string   "i2ds4"
    t.string   "x2ds4_2"
    t.string   "i2ds5"
    t.string   "x2ds5_2"
    t.string   "i3dl1"
    t.string   "x3dl1_2"
    t.string   "i3dl2"
    t.string   "x3dl2_2"
    t.string   "i3dl3"
    t.string   "x3dl3_2"
    t.string   "i3dp1"
    t.string   "x3dp1_2"
    t.string   "i3ds1"
    t.string   "x3ds1_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sample_id"
    t.index ["sample_id"], name: "index_kirs_on_sample_id"
  end

  create_table "kiruploads", force: :cascade do |t|
    t.string   "datafile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "samples", force: :cascade do |t|
    t.string   "sample_source"
    t.string   "disease"
    t.string   "received_date"
    t.string   "indigo_id"
    t.string   "site_sample_id"
    t.string   "batch"
    t.string   "sent_date"
    t.string   "gender"
    t.string   "ethnicity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "age_at_sample"
    t.string   "race"
    t.integer  "idr_id"
    t.string   "short_date"
    t.integer  "batch_id"
    t.index ["batch_id"], name: "index_samples_on_batch_id"
    t.index ["idr_id"], name: "index_samples_on_idr_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "affiliation"
    t.boolean  "approved",                          default: false
    t.string   "authentication_token",   limit: 30
    t.boolean  "sent_approved_email"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
