class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :Name
      t.decimal :Cost
      t.integer :Category
      t.boolean :Generic
      t.boolean :Special

      t.timestamps
    end
  end
end
