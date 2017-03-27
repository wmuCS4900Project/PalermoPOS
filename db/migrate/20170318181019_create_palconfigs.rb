class CreatePalconfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :palconfigs do |t|
      t.string :name
      t.string :val1
      t.string :val2
      t.text :desc

      t.timestamps
    end
  end
end
