class RemoveUnusedDbFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :Driver
    remove_column :users, :IsManager 
    
    remove_column :customers, :LastOrderNumber
    remove_column :customers, :LastOrderDate
    remove_column :customers, :TotalOrderCount
    remove_column :customers, :TotalOrderDollars
    
    remove_column :coupons, :PercentOff
    
    drop_table :drivers
    
    
  end
end
