class CouponsAdjust < ActiveRecord::Migration[5.0]
  def change
    change_column :coupons, :ProductType, :string
    change_column :coupons, :ProductMinOptions, :string
    change_column :coupons, :ProductMinPrice, :string
  end
end
