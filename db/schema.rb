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

ActiveRecord::Schema.define(:version => 20121119195458) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "comment_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.boolean "positive"
  end

  add_index "comment_votes", ["comment_id"], :name => "index_comment_votes_on_comment_id"
  add_index "comment_votes", ["user_id"], :name => "index_comment_votes_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "parent_id"
    t.boolean  "deleted",    :default => false
  end

  add_index "comments", ["topic_id"], :name => "index_comments_on_topic_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "subscriptions", :force => true do |t|
    t.integer "user_id"
    t.integer "category_id"
  end

  add_index "subscriptions", ["category_id"], :name => "index_subscriptions_on_category_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "topic_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.boolean "positive"
  end

  add_index "topic_votes", ["topic_id"], :name => "index_topic_votes_on_topic_id"
  add_index "topic_votes", ["user_id"], :name => "index_topic_votes_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "salt"
    t.boolean  "comment_notification", :default => false
    t.boolean  "reply_notification",   :default => false
    t.string   "reset_key"
  end

end
