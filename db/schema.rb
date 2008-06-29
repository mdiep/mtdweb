# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080628155435) do

  create_table "addresses", :force => true do |t|
    t.integer "contact_id",               :null => false
    t.string  "label",      :limit => 1,  :null => false
    t.string  "street",     :limit => 25
    t.string  "city",       :limit => 25
    t.string  "state",      :limit => 20
    t.string  "zip",        :limit => 15
    t.string  "street2",    :limit => 25
  end

  create_table "contacts", :force => true do |t|
    t.integer "user_id"
    t.string  "first_name",      :limit => 25, :null => false
    t.string  "spouses_name",    :limit => 25
    t.string  "last_name",       :limit => 25, :null => false
    t.text    "details"
    t.date    "created_on"
    t.integer "organization_id"
    t.integer "referred_by_id"
  end

  create_table "email_addresses", :force => true do |t|
    t.integer "contact_id",               :null => false
    t.string  "label",      :limit => 10
    t.string  "address",    :limit => 75
  end

  create_table "notes", :force => true do |t|
    t.integer  "contact_id",                    :null => false
    t.text     "text"
    t.datetime "timestamp",                     :null => false
    t.boolean  "contacted",  :default => false, :null => false
  end

  create_table "organizations", :force => true do |t|
    t.integer "user_id",               :null => false
    t.string  "name",    :limit => 40, :null => false
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer "contact_id",               :null => false
    t.string  "number",     :limit => 25
    t.string  "label",      :limit => 10
  end

  create_table "pledges", :force => true do |t|
    t.integer "contact_id",                                 :null => false
    t.date    "start_date",                                 :null => false
    t.date    "end_date"
    t.decimal "amount",                                     :null => false
    t.string  "frequency",  :limit => 1,                    :null => false
    t.boolean "lifelink",                :default => false, :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "contact_id"
  end

  create_table "tags", :force => true do |t|
    t.string  "name",    :limit => 25
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "is_admin",                                :default => false
  end

end
