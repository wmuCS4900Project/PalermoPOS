class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
