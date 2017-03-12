class AddCouponListToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :Coupons, :string
  end
end
