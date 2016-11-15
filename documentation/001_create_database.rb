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

class CreateDatabase < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define(version: 0) do
    
      create_table "customers", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.string   "Phone",             limit: 10
        t.string   "LastName",          limit: 40
        t.string   "FirstName",         limit: 20
        t.string   "AddressNumber",     limit: 10
        t.string   "StreetName",        limit: 30
        t.string   "City",              limit: 20
        t.string   "State",             limit: 2
        t.integer  "Zip"
        t.string   "Directions",        limit: 100
        t.integer  "LastOrderNumber"
        t.datetime "FirstOrderDate"
        t.decimal  "TotalOrderDollars",             precision: 7, scale: 2
        t.integer  "TotalOrderCount"
        t.integer  "BadCkAmt"
        t.decimal  "BadCkCount",                    precision: 7, scale: 2
        t.boolean  "LongDelivery"
        t.datetime "LastOrderDate"
        t.string   "Notes",             limit: 100
      end
    
      create_table "options", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.string  "Name",            limit: 30
        t.integer "ProductParentID"
        t.decimal "Cost",                       precision: 7, scale: 2
        t.index ["ProductParentID"], name: "ProductParentID", using: :btree
      end
    
      create_table "orderline", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.integer "OrderID"
        t.integer "ProductParentID"
        t.string  "Options",         limit: 50
        t.decimal "ItemTotalCost",              precision: 7, scale: 2
        t.index ["OrderID"], name: "OrderID", using: :btree
      end
    
      create_table "orders", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.integer  "CustomerID"
        t.integer  "UserID"
        t.date     "OrderDate"
        t.datetime "Ordertime"
        t.decimal  "TotalCost",  precision: 7, scale: 2
        t.boolean  "Paid"
        t.integer  "DriverID"
        t.decimal  "Discounts",  precision: 7, scale: 2
        t.decimal  "AmountPaid", precision: 7, scale: 2
        t.decimal  "ChangeDue",  precision: 7, scale: 2
        t.decimal  "TIP",        precision: 7, scale: 2
        t.index ["CustomerID"], name: "CustomerID", using: :btree
        t.index ["DriverID"], name: "DriverID", using: :btree
        t.index ["UserID"], name: "UserID", using: :btree
      end
    
      create_table "products", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.string  "ProductName",     limit: 30
        t.decimal "Cost",                       precision: 7, scale: 2
        t.integer "ProductCategory"
        t.boolean "Generic"
      end
    
      create_table "users", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
        t.string   "UserName",  limit: 30
        t.string   "Password",  limit: 30
        t.boolean  "Driver"
        t.datetime "DateAdded"
        t.boolean  "IsManager"
      end
    
      add_foreign_key "options", "products", column: "ProductParentID", primary_key: "ID", name: "options_ibfk_1", on_delete: :cascade
      add_foreign_key "orderline", "orders", column: "OrderID", primary_key: "ID", name: "orderline_ibfk_1", on_delete: :cascade
      add_foreign_key "orders", "customers", column: "CustomerID", primary_key: "ID", name: "orders_ibfk_1"
      add_foreign_key "orders", "users", column: "DriverID", primary_key: "ID", name: "orders_ibfk_3"
      add_foreign_key "orders", "users", column: "UserID", primary_key: "ID", name: "orders_ibfk_2"
    end
  end
  
  def self.down
  end
end
