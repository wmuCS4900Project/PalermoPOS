class CreateCaps < ActiveRecord::Migration[5.0]
  def change
    create_table :caps do |t|
      t.integer :role_id
      t.string :action
      t.string :object

      t.timestamps
    end
  end
end
