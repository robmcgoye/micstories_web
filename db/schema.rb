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

ActiveRecord::Schema.define(version: 2022_04_22_174513) do

  create_table "chapters", force: :cascade do |t|
    t.integer "story_id", null: false
    t.string "title"
    t.string "subtitle"
    t.integer "sort_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["story_id"], name: "index_chapters_on_story_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "full_name"
    t.string "chat_name"
    t.text "description"
    t.integer "sort_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "part_id", null: false
    t.integer "character_id", null: false
    t.boolean "published"
    t.datetime "publish_at"
    t.integer "sort_order"
    t.text "post"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_chats_on_character_id"
    t.index ["part_id"], name: "index_chats_on_part_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parts", force: :cascade do |t|
    t.integer "chapter_id", null: false
    t.string "title"
    t.string "subtitle"
    t.string "chat_title"
    t.boolean "published"
    t.text "content"
    t.integer "sort_order"
    t.datetime "publish_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chapter_id"], name: "index_parts_on_chapter_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "long_title"
    t.string "short_title"
    t.string "header_picture"
    t.boolean "published"
    t.string "author"
    t.integer "sort_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tiny_images", force: :cascade do |t|
    t.string "file"
    t.string "alt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "chapters", "stories"
  add_foreign_key "chats", "characters"
  add_foreign_key "chats", "parts"
  add_foreign_key "parts", "chapters"
end
