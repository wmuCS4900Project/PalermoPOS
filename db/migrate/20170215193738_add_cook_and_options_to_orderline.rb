class AddCookAndOptionsToOrderline < ActiveRecord::Migration[5.0]
  def change
    add_column :orderlines, :Comments, :string
    add_column :orderlines, :HowCooked, :integer
  end
end
