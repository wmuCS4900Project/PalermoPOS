class AddAbbreviationToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :Abbreviation, :string
  end
end
