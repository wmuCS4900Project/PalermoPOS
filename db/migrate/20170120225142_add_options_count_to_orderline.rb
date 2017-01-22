class AddOptionsCountToOrderline < ActiveRecord::Migration[5.0]
  def change
    add_column :orderlines, :OptionCount, :decimal, :precision => 8, :scale => 2
  end
end
