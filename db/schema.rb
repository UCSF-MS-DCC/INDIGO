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

ActiveRecord::Schema.define(version: 20170418212623) do

  create_table "batch_gwas", force: :cascade do |t|
    t.integer  "batch_id"
    t.integer  "gwas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batches", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "disease"
    t.string   "date_received_from_source"
    t.string   "samples_sent_to_stanford"
    t.integer  "dataset_id"
    t.boolean  "to_stanford"
    t.integer  "samples_control_male"
    t.integer  "samples_control_female"
    t.integer  "samples_control_gender_unknown"
    t.integer  "samples_case_male"
    t.integer  "samples_case_female"
    t.integer  "samples_case_gender_unknown"
    t.integer  "hlas_control_male"
    t.integer  "hlas_control_female"
    t.integer  "hlas_control_gender_unknown"
    t.integer  "hlas_case_male"
    t.integer  "hlas_case_female"
    t.integer  "hlas_case_gender_unknown"
    t.integer  "kirs_case_male"
    t.integer  "kirs_case_female"
    t.integer  "kirs_case_gender_unknown"
    t.integer  "kirs_control_male"
    t.integer  "kirs_control_female"
    t.integer  "kirs_control_gender_unknown"
    t.integer  "samples_unknown_disease_male"
    t.integer  "samples_unknown_disease_female"
    t.integer  "samples_unknown_disease_unknown_gender"
    t.integer  "hlas_unknown_disease_male"
    t.integer  "hlas_unknown_disease_female"
    t.integer  "hlas_unknown_disease_unknown_gender"
    t.integer  "kirs_unknown_disease_male"
    t.integer  "kirs_unknown_disease_female"
    t.integer  "kirs_unknown_disease_unknown_gender"
    t.integer  "gwas_samples_count"
    t.index ["dataset_id"], name: "index_batches_on_dataset_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "expected_discovery"
    t.string   "demographic"
    t.string   "disease"
    t.string   "sequence_type"
  end

  create_table "consensus_fastqs", force: :cascade do |t|
    t.string   "INDIGO_ID"
    t.string   "gene"
    t.text     "fastq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "datasets", force: :cascade do |t|
    t.string   "source"
    t.integer  "expected_discovery"
    t.string   "disease"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "collaborator_id"
    t.string   "population"
    t.integer  "total_samples_male"
    t.integer  "total_samples_female"
    t.integer  "samples_male_cases"
    t.integer  "samples_female_cases"
    t.integer  "samples_male_controls"
    t.integer  "samples_female_controls"
    t.integer  "hla_available_male_controls"
    t.integer  "hla_available_female_controls"
    t.integer  "kir_available_male"
    t.integer  "kir_available_female"
    t.integer  "hla_available_male_cases"
    t.integer  "hla_available_female_cases"
    t.integer  "total_samples_sent_to_stanford"
    t.integer  "total_samples"
    t.index ["collaborator_id"], name: "index_datasets_on_collaborator_id"
  end

  create_table "gwas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "url"
  end

  create_table "gwas_samples", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sample_id"
    t.integer  "gwas_id"
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
    t.string   "version"
    t.index ["sample_id"], name: "index_hlas_on_sample_id"
  end

  create_table "hlauploads", force: :cascade do |t|
    t.string   "datafile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "version"
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
    t.integer  "age_of_onset"
    t.string   "hla_version"
    t.string   "kir_version"
  end

  create_table "keys", force: :cascade do |t|
    t.string   "keyfile"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "upload_file"
  end

  create_table "kirs", force: :cascade do |t|
    t.string   "indigo_id"
    t.string   "KIR3DL2"
    t.string   "KIR2DS5"
    t.string   "KIR2DL4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "KIR3DL1"
    t.text     "KIR3DS1"
    t.integer  "sample_id"
    t.text     "KIR2DL1"
    t.text     "KIR2DL2"
    t.text     "KIR2DL3"
    t.text     "KIR2DL5A"
    t.text     "KIR2DL5B"
    t.text     "KIR2DS1"
    t.text     "KIR2DS2"
    t.text     "KIR2DS3"
    t.text     "KIR2DS4"
    t.text     "KIR2DP1"
    t.text     "KIR3DL3"
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
    t.string   "sample_source_identifier"
    t.string   "gender"
    t.string   "ethnicity"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "age_at_sample"
    t.string   "race"
    t.integer  "batch_id"
    t.integer  "age_of_onset"
    t.index ["batch_id"], name: "index_samples_on_batch_id"
  end

  create_table "upload_reports", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "file"
    t.integer  "uploads"
    t.integer  "failed_uploads"
    t.string   "upload_type"
    t.integer  "uploaded_by"
    t.integer  "duplicates"
    t.boolean  "duplicate_upload"
    t.text     "error_message"
    t.string   "upload_datetime"
    t.integer  "added"
    t.integer  "failed"
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
