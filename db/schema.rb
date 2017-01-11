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

ActiveRecord::Schema.define(version: 20170111200703) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Name"
    t.boolean  "Splits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Phone"
    t.string   "LastName"
    t.string   "FirstName"
    t.string   "AddressNumber"
    t.string   "StreetName"
    t.string   "City"
    t.string   "State"
    t.integer  "Zip"
    t.string   "Directions"
    t.integer  "LastOrderNumber"
    t.datetime "FirstOrderDate"
    t.integer  "TotalOrderCount"
    t.decimal  "TotalOrderDollars", precision: 8, scale: 2
    t.integer  "BadCkCount"
    t.decimal  "BadCkTotal",        precision: 8, scale: 2
    t.boolean  "LongDelivery"
    t.datetime "LastOrderDate"
    t.string   "Notes"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "drivers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drivers_on_user_id", using: :btree
  end

  create_table "options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Name"
    t.decimal  "Cost",         precision: 8, scale: 2
    t.integer  "category_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "Abbreviation"
    t.index ["category_id"], name: "index_options_on_category_id", using: :btree
  end

  create_table "orderlines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal  "ItemTotalCost", precision: 8, scale: 2
    t.integer  "product_id"
    t.integer  "order_id"
    t.string   "Options1"
    t.string   "Options2"
    t.string   "Options3"
    t.string   "Options4"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "splitstyle",                            default: 0
    t.index ["order_id"], name: "index_orderlines_on_order_id", using: :btree
    t.index ["product_id"], name: "index_orderlines_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "TimeOrdered"
    t.decimal  "TotalCost",   precision: 8, scale: 2
    t.boolean  "PaidFor"
    t.integer  "DriverID"
    t.decimal  "Discounts",   precision: 8, scale: 2
    t.decimal  "AmountPaid",  precision: 8, scale: 2
    t.decimal  "ChangeDue",   precision: 8, scale: 2
    t.decimal  "Tip",         precision: 8, scale: 2
    t.integer  "user_id"
    t.integer  "customer_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "Tax",         precision: 8, scale: 2
    t.boolean  "PaidCash"
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Name"
    t.decimal  "Cost",         precision: 8, scale: 2
    t.string   "freeoptions"
    t.integer  "category_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "Abbreviation"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Name"
    t.string   "Password"
    t.boolean  "Driver"
    t.boolean  "IsManager"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "username"
  end

  add_foreign_key "drivers", "users"
  add_foreign_key "options", "categories"
  add_foreign_key "orderlines", "orders"
  add_foreign_key "orderlines", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
end
