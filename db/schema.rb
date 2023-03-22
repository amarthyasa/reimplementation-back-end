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

ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "answers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "question_id", default: 0, null: false
    t.integer "answer"
    t.text "comments"
    t.integer "response_id"
    t.index ["question_id"], name: "fk_score_questions"
    t.index ["response_id"], name: "fk_score_response"
  end

  create_table "assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "directory_path"
    t.integer "submitter_count"
    t.integer "course_id"
    t.integer "instructor_id"
    t.boolean "private"
    t.integer "num_reviews"
    t.integer "num_review_of_reviews"
    t.integer "num_review_of_reviewers"
    t.boolean "reviews_visible_to_all"
    t.integer "num_reviewers"
    t.text "spec_location"
    t.integer "max_team_size"
    t.boolean "staggered_deadline"
    t.boolean "allow_suggestions"
    t.integer "days_between_submissions"
    t.string "review_assignment_strategy"
    t.integer "max_reviews_per_submission"
    t.integer "review_topic_threshold"
    t.boolean "copy_flag"
    t.integer "rounds_of_reviews"
    t.boolean "microtask"
    t.boolean "require_quiz"
    t.integer "num_quiz_questions"
    t.boolean "is_coding_assignment"
    t.boolean "is_intelligent"
    t.boolean "calculate_penalty"
    t.integer "late_policy_id"
    t.boolean "is_penalty_calculated"
    t.integer "max_bids"
    t.boolean "show_teammate_reviews"
    t.boolean "availability_flag"
    t.boolean "use_bookmark"
    t.boolean "can_review_same_topic"
    t.boolean "can_choose_topic_to_review"
    t.boolean "is_calibrated"
    t.boolean "is_selfreview_enabled"
    t.string "reputation_algorithm"
    t.boolean "is_anonymous"
    t.integer "num_reviews_required"
    t.integer "num_metareviews_required"
    t.integer "num_metareviews_allowed"
    t.integer "num_reviews_allowed"
    t.integer "simicheck"
    t.integer "simicheck_threshold"
    t.boolean "is_answer_tagging_allowed"
    t.boolean "has_badge"
    t.boolean "allow_selecting_additional_reviews_after_1st_round"
    t.integer "sample_assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "grade"
    t.boolean "can_submit"
    t.boolean "can_review"
    t.integer "user_id"
    t.string "handle"
    t.boolean "can_take_quiz", default: true
  end

  create_table "response_maps", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "reviewed_object_id", default: 0, null: false
    t.integer "reviewer_id", default: 0, null: false
    t.integer "reviewee_id", default: 0, null: false
    t.string "type", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "calibrate_to", default: false
    t.boolean "team_reviewing_enabled", default: false
    t.index ["reviewer_id"], name: "fk_response_map_reviewer"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.integer "default_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "fk_rails_4404228d2f"
  end

  create_table "sign_up_topics", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "topic_name", null: false
  end

  create_table "signed_up_teams", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "topic_id", default: 0, null: false
    t.integer "team_id", default: 0, null: false
    t.boolean "is_waitlisted", default: false, null: false
    t.integer "preference_priority_number"
    t.index ["topic_id"], name: "fk_signed_up_users_sign_up_topics"
  end

  create_table "teams", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "type"
    t.text "comments_for_advertisement"
    t.boolean "advertise_for_partner"
    t.text "submitted_hyperlinks"
    t.integer "directory_num"
    t.integer "grade_for_submission"
    t.text "comment_for_submission"
    t.boolean "make_public", default: false
    t.integer "pair_programming_request", limit: 1
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "role_id"
    t.string "fullname"
    t.string "email"
    t.integer "parent_id"
    t.string "mru_directory_path"
    t.boolean "email_on_review"
    t.boolean "email_on_submission"
    t.boolean "email_on_review_of_review"
    t.boolean "is_new_user"
    t.boolean "master_permission_granted"
    t.string "handle"
    t.string "persistence_token"
    t.string "timezonepref"
    t.boolean "copy_of_emails"
    t.integer "institution_id"
    t.boolean "etc_icons_on_homepage"
    t.integer "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  create_table "responses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "map_id", default: 0, null: false
    t.text "additional_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "version_num"
    t.integer "round"
    t.boolean "is_submitted", default: false
    t.string "visibility", default: "private"
    t.index ["map_id"], name: "fk_response_response_map"
  end


  create_table "teams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "type"
    t.text "comments_for_advertisement"
    t.boolean "advertise_for_partner"
    t.text "submitted_hyperlinks"
    t.integer "directory_num"
    t.integer "grade_for_submission"
    t.text "comment_for_submission"
    t.boolean "make_public", default: false
    t.integer "pair_programming_request", limit: 1
  end

  create_table "teams_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.integer "duty_id"
    t.string "pair_programming_status", limit: 1
    t.index ["duty_id"], name: "index_teams_users_on_duty_id"
    t.index ["team_id"], name: "fk_users_teams"
    t.index ["user_id"], name: "fk_teams_users"
  end

  add_foreign_key "roles", "roles", column: "parent_id", on_delete: :cascade
end
