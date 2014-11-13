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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131025061758) do

  create_table "bids", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "comment"
    t.integer  "bid_count",  :default => 0
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.integer  "country_id"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.integer  "course_hours"
    t.string   "course_days"
    t.date     "to_date"
    t.date     "from_date"
    t.string   "course_type"
    t.string   "price"
    t.string   "categories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creative_folios", :force => true do |t|
    t.integer  "user_id"
    t.string   "folio_file_name"
    t.string   "folio_content_type"
    t.integer  "folio_file_size"
    t.string   "title"
    t.string   "technique"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "liker_id"
    t.integer  "course_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bid_id"
    t.integer  "project_id"
    t.integer  "course_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_recommenders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "topic"
    t.string   "categories"
    t.string   "status"
    t.integer  "payment"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "description"
    t.string   "community"
    t.string   "allow_vote"
    t.string   "allow_customers"
    t.string   "creative_comment_pieces"
    t.string   "creative_comment_project"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bid_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommenders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recommender_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commenter_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewer_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "user_name"
    t.string   "role"
    t.string   "surname"
    t.datetime "date_of_birth"
    t.integer  "document_num"
    t.string   "document_type"
    t.text     "about_me"
    t.string   "retrived_title"
    t.string   "currently_studying"
    t.string   "current_occupation"
    t.string   "occupation"
    t.string   "creative_am"
    t.string   "participate_in_trining"
    t.string   "layout_work"
    t.string   "invite_private_calls"
    t.string   "outstanding_releave"
    t.string   "skills"
    t.string   "receive_news"
    t.string   "company_name"
    t.integer  "charge"
    t.string   "provision"
    t.text     "class_description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "working_arrangements"
    t.string   "name"
    t.string   "country"
    t.string   "city"
    t.string   "formal_duites"
    t.string   "position"
    t.string   "laboral_disposition"
    t.string   "schedule"
    t.string   "phone"
    t.string   "sex"
    t.text     "text_accept"
    t.integer  "subscription",                          :default => 0
    t.integer  "post_work",                             :default => 0
    t.integer  "post_class",                            :default => 0
    t.integer  "recommendations",                       :default => 0
    t.integer  "country_id"
    t.integer  "city_id"
    t.string   "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visitors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "view"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
