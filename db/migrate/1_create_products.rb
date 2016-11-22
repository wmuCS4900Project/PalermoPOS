class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :Name
      t.decimal :Cost, :precision => 8, :scale => 2
      t.integer :Category
      t.boolean :Generic
      t.boolean :Special
      t.boolean :DoesHalves
      t.boolean :DoesQuarters

      t.timestamps
    end
  end
end
