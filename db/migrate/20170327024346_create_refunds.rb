class CreateRefunds < ActiveRecord::Migration[5.0]
  def change
    create_table :refunds do |t|
      t.integer :order_id
      t.decimal :tax, :precision => 8, :scale => 2 
      t.decimal :subtotal, :precision => 8, :scale => 2
      t.decimal :total, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
