class AddTaxToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :Tax, :decimal, :precision => 8, :scale => 2
  end
end
