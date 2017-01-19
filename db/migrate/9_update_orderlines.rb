class UpdateOrderlines< ActiveRecord::Migration[5.0]
  def change
    remove_column :orderlines, :split
    add_column :orderlines, :splitstyle, :integer, default: 0
  end
end
