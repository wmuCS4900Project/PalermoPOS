class AddFavoritesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :Favorite, :bool
    add_column :products, :FavoritePriority, :integer
  end
end
