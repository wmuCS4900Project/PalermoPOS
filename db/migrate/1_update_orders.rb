class UpdateOrders < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|

      t.references :customer, foreign_key: true

     
    end
  end
end
