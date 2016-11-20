class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :TimeOrdered
      t.decimal :TotalCost
      t.boolean :PaidFor
      t.integer :DriverID
      t.decimal :Discounts
      t.decimal :AmountPaid
      t.decimal :ChangeDue
      t.decimal :Tip
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
