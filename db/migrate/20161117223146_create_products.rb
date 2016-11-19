class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :ProductName
      t.decimal :Cost
      t.column :ProductCategory, :integer
      t.boolean :Generic

      t.timestamps
    end
  end
end
