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

ActiveRecord::Schema[7.1].define(version: 2024_06_21_183909) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allergy_reactions", force: :cascade do |t|
    t.integer "reaction", null: false
    t.integer "severity", null: false
    t.bigint "allergy_records_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allergy_records_id"], name: "index_allergy_reactions_on_allergy_records_id"
  end

  create_table "allergy_records", force: :cascade do |t|
    t.string "name"
    t.bigint "pets_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pets_id"], name: "index_allergy_records_on_pets_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", null: false
    t.integer "species", null: false
    t.string "owner_first", null: false
    t.string "owner_last", null: false
    t.date "date_of_birth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaccine_records", force: :cascade do |t|
    t.string "name", null: false
    t.date "date_administered", null: false
    t.bigint "pets_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pets_id"], name: "index_vaccine_records_on_pets_id"
  end

  add_foreign_key "allergy_reactions", "allergy_records", column: "allergy_records_id"
  add_foreign_key "allergy_records", "pets", column: "pets_id"
  add_foreign_key "vaccine_records", "pets", column: "pets_id"
end
