class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :username
      t.string :Password
      t.boolean :Driver
      t.boolean :IsManager

      t.timestamps
    end
  end
end
