class RemovePriceFromCouponReqs < ActiveRecord::Migration[5.0]
  def change
    remove_column :coupons, :ProductMinPrice
  end
end
