class CreateOrderlines < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlines do |t|
      t.string :Options
      t.decimal :ItemTotalCost
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
