class AddProductAndOptionsAbbreviations < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :Abbreviation, :string
    add_column :options, :Abbreviation, :string
  end
end
