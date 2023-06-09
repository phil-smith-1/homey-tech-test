# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_311_135_853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'text'
    t.integer 'project_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events', force: :cascade do |t|
    t.integer 'project_id'
    t.string 'eventable_type', null: false
    t.bigint 'eventable_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[eventable_type eventable_id], name: 'index_events_on_eventable'
  end

  create_table 'project_transitions', force: :cascade do |t|
    t.string 'to_state', null: false
    t.json 'metadata', default: {}
    t.integer 'sort_key', null: false
    t.integer 'project_id', null: false
    t.boolean 'most_recent', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[project_id most_recent], name: 'index_project_transitions_parent_most_recent', unique: true,
                                        where: 'most_recent'
    t.index %w[project_id sort_key], name: 'index_project_transitions_parent_sort', unique: true
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'comments', 'projects'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'project_transitions', 'projects'
end
