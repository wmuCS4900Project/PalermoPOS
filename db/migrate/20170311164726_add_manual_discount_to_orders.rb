class AddManualDiscountToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ManualDiscount, :decimal, :precision => 8, :scale => 2
  end
end
