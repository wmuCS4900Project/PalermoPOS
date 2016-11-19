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

ActiveRecord::Schema.define(version: 20161117225214) do

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
    t.decimal  "TotalOrderDollars", precision: 10
    t.integer  "TotalOrderCount"
    t.integer  "BadCkAmt"
    t.decimal  "BadCkCount",        precision: 10
    t.boolean  "LongDelivery"
    t.datetime "LastOrderDate"
    t.string   "Notes"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "Name"
    t.decimal  "Cost",       precision: 10
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "orderlines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "ProductName"
    t.string   "Options"
    t.decimal  "ItemTotalCost", precision: 10
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "OrderTime"
    t.decimal  "TotalCost",  precision: 10
    t.boolean  "Paid"
    t.integer  "DriverID"
    t.decimal  "Discounts",  precision: 10
    t.decimal  "AmountPaid", precision: 10
    t.decimal  "ChangeDue",  precision: 10
    t.decimal  "TIP",        precision: 10
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "ProductName"
    t.decimal  "Cost",            precision: 10
    t.integer  "ProductCategory"
    t.boolean  "Generic"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "UserName"
    t.string   "Password"
    t.boolean  "Driver"
    t.boolean  "IsManager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
