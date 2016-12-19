class CreateOrderlines < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlines do |e|
      e.decimal :ItemTotalCost, :precision => 8, :scale => 2
      e.references :product, foreign_key: true
      e.references :order, foreign_key: true
      e.integer :Split
      e.string :Options1
      e.string :Options2
      e.string :Options3
      e.string :Options4

      e.timestamps
    end
  end
end
