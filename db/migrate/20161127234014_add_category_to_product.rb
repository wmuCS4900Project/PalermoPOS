class AddCategoryToProduct < ActiveRecord::Migration[5.0]
  def change
    change_table :products do |t|
      t.remove :doeshalves, :doesquarters, :generic, :special, :category
      t.references :category, foreign_key: true
    end
  end
end
