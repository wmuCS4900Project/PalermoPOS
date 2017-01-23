class AddSubTotalToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :Subtotal, :decimal, :precision => 8, :scale => 2
  end
end
