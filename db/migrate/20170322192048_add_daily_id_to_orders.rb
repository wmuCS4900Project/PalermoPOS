class AddDailyIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :DailyID, :integer
  end
end
