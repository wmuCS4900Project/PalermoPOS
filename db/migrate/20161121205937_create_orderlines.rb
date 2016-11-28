class CreateOrderlines < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlines do |t|
      t.decimal :ItemTotalCost
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :Split
      t.string :Options1
      t.string :Options2
      t.string :Options3
      t.string :Options4

      t.timestamps
    end
  end
end
