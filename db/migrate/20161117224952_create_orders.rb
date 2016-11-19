class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :OrderTime
      t.decimal :TotalCost
      t.boolean :Paid
      t.integer :DriverID
      t.decimal :Discounts
      t.decimal :AmountPaid
      t.decimal :ChangeDue
      t.decimal :TIP

      t.timestamps
    end
  end
end
