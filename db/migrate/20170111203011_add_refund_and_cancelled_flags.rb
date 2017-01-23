class AddRefundAndCancelledFlags < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :Cancelled, :bool
    add_column :orders, :Refunded, :bool
    add_column :orders, :RefundedTotal, :decimal, :precision => 8, :scale => 2
  end
end
