class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :TimeOrdered
      t.decimal :TotalCost, :precision => 8, :scale => 2
      t.boolean :PaidFor
      t.integer :DriverID
      t.decimal :Discounts, :precision => 8, :scale => 2
      t.decimal :AmountPaid, :precision => 8, :scale => 2
      t.decimal :ChangeDue, :precision => 8, :scale => 2
      t.decimal :Tip, :precision => 8, :scale => 2
      t.references :user, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
