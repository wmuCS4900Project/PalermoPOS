class CreateOptions < ActiveRecord::Migration[5.0]
  def change
      create_table :options do |t|
      t.string :Name
      t.decimal :Cost, :precision => 8, :scale => 2
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
