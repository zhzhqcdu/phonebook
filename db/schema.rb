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

ActiveRecord::Schema.define(:version => 20130805124831) do

  create_table "memberships", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "organ_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organs", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "ancestry"
    t.string   "office_room"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "actors", :force => true do |t|
    t.integer  "membership_id", :null => false
    t.integer  "organ_id",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "actors_users", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "actor_id", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "username",             :null => false
    t.string   "encrypted_password",   :null => false
    t.string   "authentication_token"
    t.string   "state"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

end
