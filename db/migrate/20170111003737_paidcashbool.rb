class Paidcashbool < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :PaidCash, :bool
  end
end
