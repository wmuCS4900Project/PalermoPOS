class RemoveTimeOrderedAndAddDeliveryBoolToOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :TimeOrdered
    add_column :orders, :IsDelivery, :bool
  end
end
