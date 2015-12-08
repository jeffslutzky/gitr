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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151208192734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaborators", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaborators_projects", id: false, force: :cascade do |t|
    t.integer "collaborator_id"
    t.integer "project_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.string   "closed_at"
    t.datetime "updated_at", null: false
    t.integer  "project_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "state"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "collaborator_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "github_repo_id"
    t.integer  "admin_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "url"
    t.text     "description"
    t.boolean  "active",         default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "uid"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "username"
    t.string   "avatar_url"
  end

end
