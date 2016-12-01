class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :Phone
      t.string :LastName
      t.string :FirstName
      t.string :AddressNumber
      t.string :StreetName
      t.string :City
      t.string :State
      t.integer :Zip
      t.string :Directions
      t.integer :LastOrderNumber
      t.datetime :FirstOrderDate
      t.decimal :TotalOrderDollars
      t.integer :TotalOrderCount
      t.integer :BadCkAmt
      t.decimal :BadCkCount
      t.boolean :LongDelivery
      t.datetime :LastOrderDate
      t.string :Notes

      t.timestamps
    end
  end
end
