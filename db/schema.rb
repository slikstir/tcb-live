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

ActiveRecord::Schema[8.0].define(version: 2025_05_09_145101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attendees", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.string "sort"
    t.string "title"
    t.string "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["poll_id"], name: "index_choices_on_poll_id"
  end

  create_table "links", force: :cascade do |t|
    t.bigint "show_id", null: false
    t.string "label"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_links_on_show_id"
  end

  create_table "live_stream_polls", force: :cascade do |t|
    t.bigint "live_stream_id", null: false
    t.bigint "poll_id", null: false
    t.string "stream_delay"
    t.boolean "count_votes", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["live_stream_id"], name: "index_live_stream_polls_on_live_stream_id"
    t.index ["poll_id"], name: "index_live_stream_polls_on_poll_id"
  end

  create_table "live_streams", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "stream_delay", default: 0, null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", default: "", null: false
    t.string "state"
    t.index ["show_id"], name: "index_live_streams_on_show_id"
  end

  create_table "polls", force: :cascade do |t|
    t.bigint "show_id", null: false
    t.integer "sort", default: 0
    t.string "state", default: "closed"
    t.string "kind"
    t.string "question"
    t.string "subtitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_polls_on_show_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.string "value_type"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_settings_on_code"
  end

  create_table "show_attendees", force: :cascade do |t|
    t.bigint "deprecated_show_id"
    t.bigint "attendee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attendable_type"
    t.bigint "attendable_id"
    t.index ["attendable_type", "attendable_id"], name: "index_show_attendees_on_attendable"
    t.index ["attendee_id"], name: "index_show_attendees_on_attendee_id"
    t.index ["deprecated_show_id"], name: "index_show_attendees_on_deprecated_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "template_id"
    t.datetime "date"
    t.string "state"
    t.string "code"
    t.integer "audience_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_shows_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.string "heading_bg_color"
    t.string "heading_text_color"
    t.string "light_page_bg_color"
    t.string "light_page_titles"
    t.string "light_page_subtitles"
    t.string "dark_page_bg_color"
    t.string "dark_page_titles"
    t.string "dark_page_subtitles"
    t.string "choice_color"
    t.string "choice_title_color"
    t.string "choice_subtitle_color"
    t.string "choice_outline"
    t.string "choice_selected_outline"
    t.string "vote_color"
    t.string "vote_outline_color"
    t.string "vote_text_color"
    t.string "log_out_text_color"
    t.string "log_out_color"
    t.string "log_out_outline_color"
    t.text "google_fonts_embed"
    t.text "font_family_1"
    t.text "font_family_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "api_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "choice_id", null: false
    t.bigint "attendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 1, null: false
    t.boolean "eligible", default: true
    t.bigint "live_stream_poll_id"
    t.index ["attendee_id"], name: "index_votes_on_attendee_id"
    t.index ["choice_id"], name: "index_votes_on_choice_id"
    t.index ["live_stream_poll_id"], name: "index_votes_on_live_stream_poll_id"
    t.index ["poll_id"], name: "index_votes_on_poll_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "choices", "polls"
  add_foreign_key "links", "shows"
  add_foreign_key "live_stream_polls", "live_streams"
  add_foreign_key "live_stream_polls", "polls"
  add_foreign_key "live_streams", "shows"
  add_foreign_key "polls", "shows"
  add_foreign_key "show_attendees", "attendees"
  add_foreign_key "show_attendees", "shows", column: "deprecated_show_id"
  add_foreign_key "votes", "attendees"
  add_foreign_key "votes", "choices"
  add_foreign_key "votes", "polls"
end
