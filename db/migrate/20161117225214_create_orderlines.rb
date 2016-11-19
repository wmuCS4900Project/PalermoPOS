class CreateOrderlines < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlines do |t|
      t.integer :ProductID
      t.string :Options
      t.decimal :ItemTotalCost

      t.timestamps
    end
  end
end
