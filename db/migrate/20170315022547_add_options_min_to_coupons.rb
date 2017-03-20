class AddOptionsMinToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :Requirements3, :string
  end
end
