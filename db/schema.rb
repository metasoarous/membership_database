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

ActiveRecord::Schema.define(:version => 20101030023257) do

  create_table "member_volunteer_category_joins", :force => true do |t|
    t.integer  "member_id"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "membership_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "membership_volunteer_category_joins", :force => true do |t|
    t.integer  "membership_id"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "mailing_address"
    t.string   "home_address"
    t.string   "phone"
    t.string   "email"
    t.integer  "number"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "best_contact"
    t.text     "volunteer_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepts_newsletters"
  end

  create_table "renewals", :force => true do |t|
    t.date     "date"
    t.float    "payment_amount"
    t.boolean  "barter"
    t.text     "notes"
    t.integer  "membership_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteer_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
