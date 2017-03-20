class CouponsRefactor < ActiveRecord::Migration[5.0]
  def change
    remove_column :coupons, :Requirements
    remove_column :coupons, :Requirements2
    remove_column :coupons, :Requirements3
    add_column :coupons, :ProductData, :string
    add_column :coupons, :ProductType, :tinyint
    add_column :coupons, :ProductMinOptions, :tinyint
    add_column :coupons, :ProductMinPrice, :decimal, :precision => 8, :scale => 2
  end
end
