# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< Updated upstream
ActiveRecord::Schema.define(version: 2021_01_11_111320) do
=======
ActiveRecord::Schema.define(version: 2021_01_11_125729) do
>>>>>>> Stashed changes

  create_table "c_calendars", force: :cascade do |t|
    t.string "summary"
    t.string "description"
    t.datetime "dtstart"
    t.datetime "dtend"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "file_records", force: :cascade do |t|
    t.string "path"
    t.string "name"
    t.boolean "has_children"
    t.boolean "unread"
    t.boolean "course"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_file_records_on_user_id"
  end

  create_table "tasklists", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_tasklists_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.boolean "done"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.string "belongto"
    t.boolean "done"
    t.boolean "flag"
    t.datetime "duetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tasklist_id", null: false
    t.index ["tasklist_id"], name: "index_todos_on_tasklist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "timetable_ics"
    t.string "lecture_info"
  end

  add_foreign_key "file_records", "users"
  add_foreign_key "tasklists", "users"
  add_foreign_key "todos", "tasklists"
end
