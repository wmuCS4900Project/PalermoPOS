class AddDeliveryChargeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :DeliveryCharge, :decimal, :precision => 8, :scale => 2
  end
end
